package com.drivehub.dao;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * File I/O Utility for DriveHub Vehicle Rental Platform.
 * Direct text file storage using BufferedReader and BufferedWriter.
 */
public class FileUtil {

    private static String dataDirectoryPath = null;

    public static synchronized void setDataDirectory(String path) {
        dataDirectoryPath = path;
    }

    public static File getFile(String fileName) {
        File dataDir;
        if (dataDirectoryPath != null && !dataDirectoryPath.trim().isEmpty()) {
            dataDir = new File(dataDirectoryPath);
        } else {
            dataDir = new File(System.getProperty("user.dir"), "data");
            if (!dataDir.exists()) {
                File altDir = new File("data");
                if (altDir.exists()) {
                    dataDir = altDir;
                }
            }
        }

        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }

        File targetFile = new File(dataDir, fileName);
        if (!targetFile.exists()) {
            try {
                targetFile.createNewFile();
            } catch (IOException e) {
                System.err.println("Could not create file: " + targetFile.getAbsolutePath() + " -> " + e.getMessage());
            }
        }
        return targetFile;
    }

    public static synchronized List<String> readAllLines(String fileName) throws IOException {
        List<String> lines = new ArrayList<>();
        File file = getFile(fileName);

        if (!file.exists() || file.length() == 0) {
            return lines;
        }

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (!line.isEmpty() && !line.startsWith("#")) {
                    lines.add(line);
                }
            }
        }
        return lines;
    }

    public static synchronized void appendLine(String fileName, String line) throws IOException {
        File file = getFile(fileName);
        try (BufferedWriter writer = new BufferedWriter(
                new OutputStreamWriter(new FileOutputStream(file, true), StandardCharsets.UTF_8))) {
            writer.write(line);
            writer.newLine();
        }
    }

    public static synchronized void writeAllLines(String fileName, List<String> lines) throws IOException {
        File file = getFile(fileName);
        try (BufferedWriter writer = new BufferedWriter(
                new OutputStreamWriter(new FileOutputStream(file, false), StandardCharsets.UTF_8))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }
}
