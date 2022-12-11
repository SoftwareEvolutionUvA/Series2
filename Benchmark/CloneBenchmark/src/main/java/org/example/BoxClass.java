package org.example;

import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.core.ZipFile;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.net.URL;
import java.io.IOException;

public class BoxClass {
    // type 1

    /**
     * Identifier: a1
     * Type: 1
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: No comments added
     *
     * @param array
     */
    public void bubble_sort(int[] array) {
        int smaller;
        int bigger;
        boolean run = true;


        for (int i = 0; i < array.length && run; i++) {
            run = false;

            for (int y = 0; y < array.length-1; y++) {
                if(array[y] > array[y + 1]) {
                    bigger = array[y];
                    smaller = array[y + 1];
                    array[y] = smaller;
                    array[y + 1] = bigger;
                    run = true;
                }
            }
        }
    }

    /**
     * Identifier: a3
     * Type: 1
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: indention changed for if
     *
     * @param array
     */
    public void bubble_sort_a3(int[] array) {
        int smaller;
        int bigger;
        boolean run = true;


        for (int i = 0; i < array.length && run; i++) {
            run = false;

            for (int y = 0; y < array.length-1; y++) {
                if(array[y] > array[y + 1]) {
                bigger = array[y];
                smaller = array[y + 1];
                array[y] = smaller;
                array[y + 1] = bigger;
                run = true;
                }
            }
        }
    }

    /**
     * Identifier: a6
     * Type: 1
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: none
     *
     */
    public void downloadFile_a6() {
        String someUrl = "http://example.org";
        String fileName = "exampleFile.txt";
        try (BufferedInputStream in = new BufferedInputStream(new URL(someUrl).openStream());
             FileOutputStream fileOutputStream = new FileOutputStream(fileName)) {
            byte dataBuffer[] = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(dataBuffer, 0, 1024)) != -1) {
                fileOutputStream.write(dataBuffer, 0, bytesRead);
            }
        } catch (IOException e) {
            System.out.println("whatever");
        }
    }

    // type 2
    /**
     * Identifier: b2
     * Type: 2
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: rename run, add few comments and spaces
     *
     * @param array
     */
    public void bubble_sort_b2(int[] array) {
        int smaller;
        int bigger;
        boolean round = true;


        for (int i = 0; i < array.length && round; i++) {
            round = false; // idk, I'm a comment

            for (int y = 0; y < array.length-1; y++) {
                if(array[y] > array[y + 1]) {
                    // the good old swap

                    bigger = array[y];
                    smaller = array[y + 1];
                    array[y] = smaller;
                    array[y + 1] = bigger;
                    round = true;
                }
            }
        }
    }

    // type 3
    /**
     * Identifier: c3
     * Type: 3
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: rename smaller, add three lines here and there
     *
     * @param array
     */
    public void bubble_sort_c3(int[] array) {
        int sdasdr;
        int bigger;
        boolean run = true;


        for (int i = 0; i < array.length && run; i++) {
            run = false;
            System.out.println("look at me");
            for (int y = 0; y < array.length-1; y++) {
                if(array[y] > array[y + 1]) {
                    bigger = array[y];
                    sdasdr = array[y + 1];
                    char fdfd = 'g';
                    array[y] = sdasdr;
                    array[y + 1] = bigger;
                    run = true;
                }
            }
            bubble_sort(new int[] {1, 2}); // I added this, I'm so proud :)
        }
    }

    /**
     * Identifier: c7
     * Type: 3
     * Functionality: Zip a file
     * Source: https://stackoverflow.com/questions/9324933/what-is-a-good-java-library-to-zip-unzip-files
     * Notes: none
     *
     */
    public void unzip_c7() {
        String source = "does/not/exist/file.zip";
        String destination = "does/not/exist/folder";
        String password = "password";

        try {
            ZipFile zipFile = new ZipFile(source);
            if (zipFile.isEncrypted()) {
                zipFile.setPassword(password);
            }
            zipFile.extractAll(destination);
        } catch (ZipException e) {
            e.printStackTrace();
        }
    }

    /**
     * Identifier: c8
     * Type: 3
     * Functionality: Zip a file
     * Source: https://stackoverflow.com/questions/9324933/what-is-a-good-java-library-to-zip-unzip-files
     * Notes: inserted print statement, changed password name + constant
     *
     */
    public void unzip_c8() {
        String source = "does/not/exist/file.zip";
        String destination = "does/not/exist/folder";
        String pwrd = "superSecure";

        try {
            ZipFile zipFile = new ZipFile(source);
            if (zipFile.isEncrypted()) {
                System.out.println("I'm type 3!");
                zipFile.setPassword(pwrd);
            }
            zipFile.extractAll(destination);
        } catch (ZipException e) {
            e.printStackTrace();
        }
    }

    // type 4
    /**
     * Identifier: d6
     * Type: 4
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: change if to elvis
     *
     * @param b
     */
    public void transformation(int b) {
        for (int i = 0; i < 10; i++) {
            int a;
            a = (i % 2 == 0) ? b + i : b - i;
        }
    }

}
