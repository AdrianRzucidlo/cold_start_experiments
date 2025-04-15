exports.handler = async (event) => {
    event.Records.forEach((record) => {
      const message = record.Sns.Message;
      console.log(`Received: ${message}`);
    });
  
    return;
  };