// Functions v2 + Admin SDK
const { onRequest } = require('firebase-functions/v2/https');
const { onDocumentCreated } = require('firebase-functions/v2/firestore');
const admin = require('firebase-admin');

try { admin.app(); } catch { admin.initializeApp(); }

const db = admin.firestore();
const bucket = admin.storage().bucket();

// ────────────────────────────────────────────────────────────
// HTTP: receives "Build 2.0" and enqueues a job
// POST body: { "message": "Build 2.0" }
exports.sendToDrew = onRequest(async (req, res) => {
  try {
    const message = (req.body?.message || '').toLowerCase().trim();

    if (message.includes('build') && message.includes('2.0')) {
      const job = {
        type: 'v2.0',
        requestedMessage: 'Build 2.0',
        status: 'queued',
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      };
      const ref = await db.collection('buildJobs').add(job);
      return res.json({
        reply: `Got it — starting build for Version 2.0 (job: ${ref.id}). I’ll update status as stages complete.`
      });
    }

    return res.json({ reply: 'OK' });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ reply: 'Error queuing job.' });
  }
});

// ────────────────────────────────────────────────────────────
// Worker: runs when a document is created in /buildJobs
// Writes READY.txt (you already saw this) and a manifest.json.
// Also writes artifactUrl back to the job doc for your app.
exports.forgeBuildWorker = onDocumentCreated('buildJobs/{id}', async (event) => {
  const jobId = event.params.id;
  const snap = event.data;
  if (!snap) return;

  const job = snap.data();
  if (!job || job.status !== 'queued') return;

  // mark building
  await snap.ref.update({ status: 'building', updatedAt: new Date().toISOString() });

  // marker you already saw in Storage: gs://…/forge/v2/READY.txt
  await bucket.file('forge/v2/READY.txt').save('ready', { contentType: 'text/plain' });

  // TODO: put your real vault → compose steps here

  // write manifest so the app can pull results
  const folder = `forge/v2/${jobId}`;
  const manifestPath = `${folder}/manifest.json`;
  const manifest = {
    version: '2.0',
    jobId,
    generatedAt: new Date().toISOString(),
    items: [] // add real artifact list here
  };

  await bucket.file(manifestPath)
    .save(JSON.stringify(manifest, null, 2), { contentType: 'application/json' });

  const publicUrl = `https://storage.googleapis.com/${bucket.name}/${manifestPath}`;
  console.log(`[forge] wrote manifest: gs://${bucket.name}/${manifestPath}`);

  await snap.ref.update({
    status: 'complete',
    lastMessage: 'Forge v2 build complete.',
    artifactUrl: publicUrl,
    updatedAt: new Date().toISOString()
  });
});
