/* firebase/functions/index.js */

// ───────────────────────────────────────────────────────────────────────────────
// Imports & init
// ───────────────────────────────────────────────────────────────────────────────
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const { Storage } = require('@google-cloud/storage');
const storage = new Storage();
const BUCKET = `${process.env.GCLOUD_PROJECT}.appspot.com`; // default GCS bucket
const EXPORT_PREFIX = 'exports'; // gs://<bucket>/exports/<stamp>

const JSZip = require('jszip');

// Convenience handles
const db = admin.firestore();

// ───────────────────────────────────────────────────────────────────────────────
// Export helper: writes a tiny web bundle + manifest to Cloud Storage
//   - gs://<bucket>/exports/<stamp>/web.zip
//   - gs://<bucket>/exports/<stamp>/manifest.json
//   - gs://<bucket>/exports/latest.txt (pointer)
// ───────────────────────────────────────────────────────────────────────────────
async function writeExportBundle(stamp, payloadText = '') {
  const dir = `${EXPORT_PREFIX}/${stamp}`;
  const manifest = {
    version: '2.0',
    createdAt: new Date().toISOString(),
    files: [{ path: `${dir}/web.zip`, kind: 'web-bundle' }],
    note: payloadText || 'ok',
  };

  // 1) tiny placeholder web bundle (index.html) – replace later with real output
  const zip = new JSZip();
  zip.file(
    'index.html',
    `<!DOCTYPE html><html><body>Forge build ${stamp}</body></html>`
  );
  const buf = await zip.generateAsync({ type: 'nodebuffer' });

  // 2) write to Cloud Storage
  await storage.bucket(BUCKET).file(`${dir}/web.zip`).save(buf, {
    contentType: 'application/zip',
  });
  await storage
    .bucket(BUCKET)
    .file(`${dir}/manifest.json`)
    .save(JSON.stringify(manifest), { contentType: 'application/json' });

  // 3) optional: pointer to latest
  await storage
    .bucket(BUCKET)
    .file(`${EXPORT_PREFIX}/latest.txt`)
    .save(stamp, { contentType: 'text/plain' });

  return { dir };
}

// ───────────────────────────────────────────────────────────────────────────────
// Worker: fires when a new build job is created in Firestore
//   Collection path: buildJobs/{jobId}
//   Adjust the path if your collection is different.
// ───────────────────────────────────────────────────────────────────────────────
exports.forgeBuildWorker = functions
  .region('us-central1')
  .firestore.document('buildJobs/{jobId}')
  .onCreate(async (snap, ctx) => {
    const job = snap.data() || {};
    const jobId = ctx.params.jobId;

    // Stage 0: begin
    await db.doc('forge/status').set(
      {
        jobId,
        startedAt: admin.firestore.FieldValue.serverTimestamp(),
        state: 'building',
      },
      { merge: true }
    );

    // (your real build logic would go here)
    // e.g., read vault manifest, generate sources, etc.
    // For now we just touch a simple config so you can see progress in logs.
    await db.doc('forge/config').set(
      {
        lastUpdated: admin.firestore.FieldValue.serverTimestamp(),
        version: '2.0',
      },
      { merge: true }
    );

    // Stage N: done
    await db.doc('forge/status').set(
      {
        jobId,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        state: 'complete',
      },
      { merge: true }
    );

    // ➜ IMPORTANT: write export artifacts so GitHub Action can pick them up
    const stamp = Date.now().toString();
    await writeExportBundle(stamp, 'ok');

    // Optional: record a meta/lastStep
    await db.doc('meta/lastStep').set(
      {
        at: admin.firestore.FieldValue.serverTimestamp(),
        stage: 'complete',
        msg: 'Forge v2 build complete',
      },
      { merge: true }
    );

    return true;
  });

// ───────────────────────────────────────────────────────────────────────────────
// (Optional) Simple HTTPS function to verify functions deploy
// ───────────────────────────────────────────────────────────────────────────────
exports.ping = functions.region('us-central1').https.onRequest((req, res) => {
  res.status(200).send({ ok: true, time: new Date().toISOString() });
});
