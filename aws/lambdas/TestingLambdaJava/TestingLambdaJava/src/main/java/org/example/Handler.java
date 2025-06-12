package org.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.SNSEvent;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import com.google.cloud.storage.Bucket;

public class Handler implements RequestHandler<SNSEvent, Void> {

    @Override
    public Void handleRequest(SNSEvent event, Context context) {
        for (SNSEvent.SNSRecord record : event.getRecords()) {
            String message = record.getSNS().getMessage();

            try {
                Storage storage = StorageOptions.newBuilder()
                        .setProjectId("fake")
                        .build()
                        .getService();

                Iterable<Bucket> buckets = storage.list().iterateAll();
            } catch (Exception e) {
            }

            context.getLogger().log(message);
        }

        return null;
    }
}