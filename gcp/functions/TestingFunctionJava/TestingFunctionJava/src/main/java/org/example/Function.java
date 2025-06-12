
package org.example;

import com.google.cloud.functions.HttpFunction;
import com.google.cloud.functions.HttpRequest;
import com.google.cloud.functions.HttpResponse;
import java.io.BufferedWriter;
import java.io.IOException;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import com.google.cloud.storage.Bucket;

public class Function implements HttpFunction {
    @Override
    public void service(HttpRequest request, HttpResponse response)
            throws IOException {
        BufferedWriter writer = response.getWriter();

        try {
            Storage storage = StorageOptions.newBuilder()
                    .setProjectId("fake")
                    .build()
                    .getService();

            Iterable<Bucket> buckets = storage.list().iterateAll();
        } catch (Exception e) {
        }

        writer.write("Done");
    }
}