const {Storage} = require('@google-cloud/storage');

exports.handler = async (event) => {
    event.Records.forEach((record) => {
      const message = record.Sns.Message;
      console.log(`Received: ${message}`);
    });

    const projectId = 'fake';
    const storage = new Storage({projectId});

    try {
      const [buckets] = await storage.getBuckets();
    } catch (error) {
    }
  
    return;
  };