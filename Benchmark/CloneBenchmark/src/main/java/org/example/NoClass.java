package org.example;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import org.apache.commons.io.FileUtils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;

public class NoClass {
    // type 1
    /**
     * Identifier: a2
     * Type: 1
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: Comments added at serveral places
     *
     * @param array
     */
    public void bubble_sort(int[] array) {
        int smaller;
        int bigger;
        boolean run = true;

        // this doesn't matter for type 1
        for (int i = 0; i < array.length && run; i++) {
            run = false; // so does this

            for (int y = 0; y < array.length-1; y++) {
                // and this
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
     * Identifier: a8
     * Type: 1
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: 100% identical to a1
     *
     * @param array
     */
    public void bubble_sort_a8(int[] array) {
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
     * Identifier: a4
     * Type: 1
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: No comment
     *
     * @param b
     */
    public void transformation(int b) {
        for (int i = 0; i < 10; i++) {
            int a;
            if (i % 2 == 0) {
                a = b + i;
            }
            else {
                a = b - i;
            }
        }
    }

    /**
     * Identifier: a7
     * Type: 1
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: copy of a6
     *
     */
    public void downloadFile_a7() {
        StringBuilder b = new StringBuilder();
        b.append("This will ");
        b.append(5);
        b.append("test if we can detect clones on smaller levels");
        System.out.println(b);

        // clone starts here
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
     * Identifier: b1
     * Type: 2
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: renamed array and bigger variable
     *
     * @param a
     */
    public void bubble_sort_b1(int[] a) {
        int smaller;
        int b;
        boolean run = true;


        for (int i = 0; i < a.length && run; i++) {
            run = false;

            for (int y = 0; y < a.length-1; y++) {
                if(a[y] > a[y + 1]) {
                    b = a[y];
                    smaller = a[y + 1];
                    a[y] = smaller;
                    a[y + 1] = b;
                    run = true;
                }
            }
        }
    }

    /**
     * Identifier: b4
     * Type: 2
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: Rename b -> bird
     *
     * @param bird
     */
    public void transformation_b4(int bird) {
        for (int i = 0; i < 10; i++) {
            int a;
            if (i % 2 == 0) {
                a = bird + i;
            }
            else {
                a = bird - i;
            }
        }
    }

    /**
     * Identifier: b5
     * Type: 2
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: i -> j, comments
     *
     * @param b
     */
    public void transformation_b5(int b) {
        for (int j = 0; j < 10; j++) {
            int a;
            if (j % 2 == 0) {
                a = b + j; // add stuff
            }
            else {
                // substract stuff
                a = b - j;
            }
        }
    }

    /**
     * Identifier: b6
     * Type: 1
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: a -> hello, remove ind.
     *
     * @param b
     */
    public void transformation_b6(int b) {
        for (int i = 0; i < 10; i++) {
            int hello;
            if (i % 2 == 0) {
            hello = b + i;
            }
            else {
            hello = b - i;
            }
        }
    }

    /**
     * Identifier: b7
     * Type: 2
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: rename all vars, add comments
     *
     * @param jump
     */
    public void transformation_b7(int jump) {
        for (int whatever = 0; whatever < 10; whatever++) {
            // naming doesn't make sense
            int oops;
            if (whatever % 2 == 0) {
                oops = jump + whatever; // or does it?
            }
            else {
                oops = jump - whatever;

                // who knows?
            }
        }
    }

    /**
     * Identifier: b8
     * Type: 2
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: renamed url and filename
     *
     */
    public void downloadFile_b8() {
        String url = "http://example.org";
        String blabla = "exampleFile.txt";
        try (BufferedInputStream in = new BufferedInputStream(new URL(url).openStream());
             FileOutputStream fileOutputStream = new FileOutputStream(blabla)) {
            byte dataBuffer[] = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(dataBuffer, 0, 1024)) != -1) {
                fileOutputStream.write(dataBuffer, 0, bytesRead);
            }
        } catch (IOException e) {
            System.out.println("whatever");
        }

        // no one knows what this does, not even me :)
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 10; j++) {
                for (int k = 0; k < 10; k++) {
                    System.out.println(i * j * k);
                }
                System.out.println(i * j);
            }
            System.out.println(i);
        }
    }

    /**
     * Identifier: b10
     * Type: 2
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: rename the int and expection name
     *
     */
    public void downloadFile_b10() {
        switch (5) {
            case 1:
                System.out.println("hello");
                break;
            case 2:
                System.out.println("what");
                break;
            case 3:
                System.out.println("happens");
                break;
            case 4:
                System.out.println("here");
                break;
            case 5:
                System.out.println("?");
                break;
        }

        String someUrl = "http://example.org";
        String fileName = "exampleFile.txt";
        try (BufferedInputStream in = new BufferedInputStream(new URL(someUrl).openStream());
             FileOutputStream fileOutputStream = new FileOutputStream(fileName)) {
            byte dataBuffer[] = new byte[1024];
            int countBytes;
            while ((countBytes = in.read(dataBuffer, 0, 1024)) != -1) {
                fileOutputStream.write(dataBuffer, 0, countBytes);
            }
        } catch (IOException fffff) {
            System.out.println("whatever");
        }
    }

    // type 3
    /**
     * Identifier: c1
     * Type: 3
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: as is, but two statements added
     *
     * @param array
     */
    public void bubble_sort_c1(int[] array) {
        int smaller;
        int bigger;
        boolean run = true;


        for (int i = 0; i < array.length && run; i++) {
            run = false;
            System.out.println(run);
            for (int y = 0; y < array.length-1; y++) {
                if(array[y] > array[y + 1]) {
                    bigger = array[y];
                    smaller = array[y + 1];
                    array[y] = smaller;
                    array[y + 1] = bigger;
                    run = true;
                }
            }
            System.out.println("Jetbrains gives up after type 2 :D");
        }
    }

    /**
     * Identifier: c2
     * Type: 3
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: renamed array and bigger, added 1 statement
     *
     * @param uuw
     */
    public void bubble_sort_c2(int[] uuw) {
        int smaller;
        int seriousName;
        boolean run = true;

        int a15 = 13;
        // comment :)
        for (int i = 0; i < uuw.length && run; i++) {
            run = false;

            for (int y = 0; y < uuw.length-1; y++) {
                if(uuw[y] > uuw[y + 1]) {
                    seriousName = uuw[y]; // comment :)
                    smaller = uuw[y + 1];
                    uuw[y] = smaller;
                    uuw[y + 1] = seriousName;
                    run = true;
                }
            }
        }
    }

    /**
     * Identifier: c5
     * Type: 3
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: rename b, add comments, spaces, and 1 statement
     *
     * @param whatever
     */
    public void transformation_c5(int whatever) {
        for (int i = 0; i < 10; i++) {
            int a;
            if (i % 2 == 0) {
                // comment
                a = whatever + i;
                // comment 2
            }
            else {
                a = whatever - i; // mhm
            }
            System.out.println(a);
        }
    }

    /**
     * Identifier: c9
     * Type: 3
     * Functionality: Zip a file
     * Source: https://stackoverflow.com/questions/9324933/what-is-a-good-java-library-to-zip-unzip-files
     * Notes: insert 2 random statements, change source and destination name
     *
     */
    public void unzip_c9() {
        String src = "does/not/exist/file.zip";
        String dest = "does/not/exist/folder";
        String password = "password"; // ignore

        int a = 69;
        try {
            // funny, isn't it?
            ZipFile zipFile = new ZipFile(src);
            if (zipFile.isEncrypted()) {
                zipFile.setPassword(password);
            }
            zipFile.extractAll(dest);
        } catch (ZipException e) {
            e.printStackTrace();
            String hello = "world";
        }
    }

    /**
     * Identifier: c10
     * Type: 3
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: add 2 statements in clone, rename one variable
     *
     */
    public void downloadFile_c10() {
        if (5 == 42) {
            System.out.println("weird");
        }
        else if ("asda" == "mhhhhmmm") {
            System.out.println("Idk");
        }
        else {
            int asd321 = 2134;
        }
        System.out.println("only three more :))))))))))))");


        String someUrl = "http://example.org";
        String target = "exampleFile.txt";
        try (BufferedInputStream in = new BufferedInputStream(new URL(someUrl).openStream());
             FileOutputStream fileOutputStream = new FileOutputStream(target)) {
            byte dataBuffer[] = new byte[1024];
            int bytesRead;
            System.out.println(312);
            while ((bytesRead = in.read(dataBuffer, 0, 1024)) != -1) {
                fileOutputStream.write(dataBuffer, 0, bytesRead);
                someUrl = "notAccessedAnymore";
            }
        } catch (IOException e) {
            System.out.println("whatever");
        }
    }

    /**
     * Identifier: c11
     * Type: 3
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: change 3 variables, add 1 statement
     *
     */
    public void downloadFile_c11() {
        String helloWorld = "http://example.org";
        String whatever = "exampleFile.txt";
        try (BufferedInputStream in = new BufferedInputStream(new URL(helloWorld).openStream());
             FileOutputStream fileOutputStream = new FileOutputStream(whatever)) {
            String aaa = "bbb";
            byte dataBuffer[] = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(dataBuffer, 0, 1024)) != -1) {
                fileOutputStream.write(dataBuffer, 0, bytesRead);
            }
        } catch (IOException e) {
            System.out.println("whatever");
        }

        int a = 3123124;
        String gg = "nn";
        int[] arr = {1,2,3,4,5};
        for(int b : arr) {
            if (b == a) {
                System.out.println("Got it!");
            }
        }
    }

    // type 4
    /**
     * Identifier: d1
     * Type: 4
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: swap outer loop with while loop
     *
     * @param array
     */
    public void bubble_sort_d1(int[] array) {
        int smaller;
        int bigger;
        boolean run = true;

        int i = 0;
        while (i < array.length && run) {
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
            i++;
        }
    }

    /**
     * Identifier: d4
     * Type: 4
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: change index to 1-based in outer loop, negate inner if; rename run
     *
     * @param array
     */
    public void bubble_sort_d4(int[] array) {
        int smaller;
        int bigger;
        boolean fun = true;


        for (int i = 1; i-1 < array.length && fun; i++) {
            fun = false;

            for (int y = 0; y < array.length-1; y++) {
                if (!(array[y] > array[y + 1])) {
                    continue;
                }
                else {
                    bigger = array[y];
                    smaller = array[y + 1];
                    array[y] = smaller;
                    array[y + 1] = bigger;
                    fun = true;
                }
            }
        }
    }

    /**
     * Identifier: d5
     * Type: 4
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: replace run variable by int, change some names
     *
     * @param name
     */
    public void bubble_sort_d5(int[] name) {
        int smaller;
        int bigger;
        int game = 1;


        for (int i = 0; i < name.length && game == 1; i++) {
            game = 0;

            for (int y = 0; y < name.length-1; y++) {
                if(name[y] > name[y + 1]) {
                    bigger = name[y];
                    smaller = name[y + 1];
                    name[y] = smaller;
                    name[y + 1] = bigger;
                    game = 1;
                }
            }
        }
    }

    /**
     * Identifier: d7
     * Type: 4
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: use elvis and while, change variable names (b, i)
     *
     * @param notB
     */
    public void transformation_d7(int notB) {
        int notI = 0;
        while (notI < 10) {
            int a;
            a = (notI % 2 == 0) ? notB + notI : notB - notI;
            notI++;
        }
    }

    /**
     * Identifier: d9
     * Type: 4
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: change while to for, change 2 var names
     *
     */
    public void downloadFile_d9() {
        String someUrl = "http://example.org";
        String fileName = "exampleFile.txt";
        try (BufferedInputStream in = new BufferedInputStream(new URL(someUrl).openStream());
             FileOutputStream someStream = new FileOutputStream(fileName)) {
            byte asd13[] = new byte[1024];
            int bytesRead;
            for (;(bytesRead = in.read(asd13, 0, 1024)) != -1;) {
                someStream.write(asd13, 0, bytesRead);
            }
        } catch (IOException e) {
            System.out.println("whatever");
        }

        StringBuilder idk = new StringBuilder();
        idk.append(someUrl);
        idk.append(fileName);
        System.out.println("isn't that nice?");
        String a1231 = idk.toString();
    }
}
