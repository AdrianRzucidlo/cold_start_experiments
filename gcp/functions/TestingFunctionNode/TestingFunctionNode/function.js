exports.main = async (req, res) => {

  const projectId = 'fake';
    const storage = new Storage({projectId});

    try {
      const [buckets] = await storage.getBuckets();
    } catch (error) {
    }

    res.status(200).json({ message: `Ok` });
  };