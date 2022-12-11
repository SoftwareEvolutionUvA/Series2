package org.example;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.util.concurrent.ThreadLocalRandom;

public class UnderlinedClass {
    // type 1
    /**
     * Identifier: a9
     * Type: 1
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: Added whitespace here and there
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
     * Identifier: a5
     * Type: 1
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: Added some comments and spaces
     *
     * @param b
     */
    public void transformation(int b) {
        // this is irrelevant
        for (int i = 0; i < 10; i++) {
            int a; /* this too */
            if (i % 2 == 0) {
            a = b + i;
            }
            else {
             a = b - i;
            }

        }
    }

    // type 2
    /**
     * Identifier: b3
     * Type: 2
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: rename i and y, add comments
     *
     * @param array
     */
    public void bubble_sort_b3(int[] array) {
        int smaller; /*hi */
        int bigger;
        boolean run = true;


        for (int j = 0; j < array.length && run; j++) {
            run = false;

            for (int x = 0; x < array.length-1; x++) {
                if(array[x] > array[x + 1]) {
                    bigger = array[x];
                    smaller = array[x + 1]; // it's always 1
                    array[x] = smaller;
                    array[x + 1] = bigger;
                    run = true;
                }
            }
        }
    }

    /**
     * Identifier: b9
     * Type: 2
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: rename the dataBuffer, add some comments
     *
     */
    public void downloadFile_b9() {
        String someUrl = "http://example.org";
        String fileName = "exampleFile.txt";
        try (BufferedInputStream in = new BufferedInputStream(new URL(someUrl).openStream());
             FileOutputStream fileOutputStream = new FileOutputStream(fileName)) {
            // this code was written on a foggy Sunday
            byte idkAgoodName[] = new byte[1024]; // nice, right?
            int bytesRead;
            while ((bytesRead = in.read(idkAgoodName, 0, 1024)) != -1) {
                fileOutputStream.write(idkAgoodName, 0, bytesRead);
            }
        } catch (IOException e) {

            System.out.println("whatever"); // very responsible!


        }

        do {
            System.out.println("You didn't get a (high) 5!");
            if (ThreadLocalRandom.current().nextInt(1, 1) == 1) {
                System.out.println("IDEA did not understand that this branch will always be reached B)");
            }
            else {
                System.out.println("and this one never");
            }
        } while(ThreadLocalRandom.current().nextInt(1, 11) == 5);
    }

    // type 3
    /**
     * Identifier: c4
     * Type: 3
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: rename b, add 1 lines
     *
     * @param myInput
     */
    public void transformation_c4(int myInput) {
        for (int i = 0; i < 10; i++) {
            int a; // isn't this nice?
            if (i % 2 == 0) {
                a = myInput + i;
                int c = 42;
            }
            else {
                a = myInput - i;
            }
        }
    }

    /**
     * Identifier: c6
     * Type: 3
     * Functionality: Transformation of numbers
     * Source: https://www.researchgate.net/figure/Clone-Types-1-to-Type-4_fig2_335152710
     * Notes: rename a, i; add line
     *
     * @param b
     */
    public void transformation_c6(int b) {
        for (int uff = 0; uff < 10; uff++) {
            int big;
            if (uff % 2 == 0) {
                big = b + uff;
            }
            else {
                big = b - uff;
            }
            String a = "One day... I'm gonna make the onions cry.";
        }
    }

    // type 4
    /**
     * Identifier: d2
     * Type: 4
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: swap both loops with while
     *
     * @param array
     */
    public void bubble_sort_d2(int[] array) {
        int smaller;
        int bigger;
        boolean run = true;

        int i = 0;
        while (i < array.length && run) {
            run = false;

            int y = 0;
            while(y < array.length-1) {
                if(array[y] > array[y + 1]) {
                    bigger = array[y];
                    smaller = array[y + 1];
                    array[y] = smaller;
                    array[y + 1] = bigger;
                    run = true;
                }
                y++;
            }
            i++;
        }
    }

    /**
     * Identifier: d3
     * Type: 4
     * Functionality: Bubble Sort
     * Source: https://falconbyte.net/blog-java-bubblesort.php
     * Notes: Rename variables y, array, bigger; change order of statements where it makes sense
     *
     * @param a
     */
    public void bubble_sort_d3(int[] a) {
        boolean run = true;
        int biggus;
        int smaller;

        for (int i = 0; i < a.length && run; i++) {
            run = false;

            for (int idx = 0; idx < a.length-1; idx++) {
                if(a[idx] > a[idx + 1]) {
                    biggus = a[idx];
                    smaller = a[idx + 1];
                    run = true;
                    a[idx] = smaller;
                    a[idx + 1] = biggus;
                }
            }
        }
    }

    /**
     * Identifier: d8
     * Type: 4
     * Functionality: Download from web
     * Source: https://www.baeldung.com/java-download-file#using-java-io
     * Notes: change buffer size change while loop
     *
     */
    public void downloadFile_d8() {
        String a = "Hello World";
        for (char c : a.toCharArray()) {
            System.out.println(c);
        }
        int a3 = 131;
        if (a.toCharArray()[1] == 'b') {
            System.out.println("mhm, IDEA doesn't get that");
        }

        String someUrl = "http://example.org";
        String fileName = "exampleFile.txt";
        try (BufferedInputStream in = new BufferedInputStream(new URL(someUrl).openStream());
             FileOutputStream fileOutputStream = new FileOutputStream(fileName)) {
            int bytesRead;
            byte dataBuffer[] = new byte[2048];
            while (true) {
                if ((bytesRead = in.read(dataBuffer, 0, 2048)) != -1) {
                    break;
                }
                fileOutputStream.write(dataBuffer, 0, bytesRead);
            }
        } catch (IOException e) {
            System.out.println("whatever");
        }
    }
}
