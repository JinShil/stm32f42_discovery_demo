#!/usr/bin/rdmd

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.process;
import std.stdio;
import std.getopt;

void run(string cmd)
{
    writeln(cmd);
    auto result = executeShell(cmd);
    writeln(result.output);
}

void main(string[] args)
{
    string compiler;

    auto result = getopt
    (
        args,
        "compiler|c", "The compiler to use (gdc or ldc)", &compiler
    );

    if (result.helpWanted || args.length < 1 || (compiler != "gdc" && compiler != "ldc"))
    {
        writefln("USAGE: -c=gdc|ldc", args[0]);
        writeln();
        write("options:");
        defaultGetoptPrinter("", result.options);

        return;
    }

    auto sourceDir = "source";
    auto binaryDir = "binary";
    auto objectFile = buildPath(binaryDir, "firmware.o");
    auto outputFile = buildPath(binaryDir, "firmware");

    // Create any directories that may not exist
    if (!binaryDir.exists())
    {
        mkdir(binaryDir);
    }

    // remove any intermediate files
    auto cmd = "rm -f " ~ binaryDir ~ "/*";
    run(cmd);

        auto sourceFiles = sourceDir
                .dirEntries("*.d", SpanMode.depth)
                .filter!(a => a.name == "source/runtime/exception.d" || !a.name.startsWith("source/runtime"))
                .map!"a.name"
                .join(" ");

    if (compiler == "gdc")
    {
        cmd = "arm-none-eabi-gdc -c -O1 -nophoboslib -nostdinc -nodefaultlibs -nostdlib"
            ~ " -mthumb -mcpu=cortex-m4 -mtune=cortex-m4 -mfloat-abi=hard"
            ~ " -Isource/runtime" // to import runtime automatically
            ~ " -fno-bounds-check"
            ~ " -ffunction-sections"
            ~ " -fdata-sections"
            ~ " -fno-weak"
            ~ " -fno-tree-loop-distribute-patterns"
            ~ " -funroll-loops"
            ~ " -ftransition=dip1000"
            // ~ " -dip1000"
            // ~ " -S"

            ~ " " ~ sourceFiles
            ~ " -o " ~ objectFile;
    }
    else if (compiler == "ldc")
    {
        cmd = "ldc2 -conf= -disable-simplify-libcalls -c -Os"
            ~ " -mtriple=thumb-none-eabi -float-abi=hard"
            ~ " -mcpu=cortex-m4"
            ~ " -Isource/runtime" // to import runtime automatically
            ~ " -boundscheck=off"
            ~ " -linkonce-templates"
            ~ " -dip1000"
            // ~ " -output-s"

            ~ " " ~ sourceFiles
            ~ " -of=" ~ objectFile;
    }
    else
    {
        assert(false);
    }
    run(cmd);

    // link, creating executable
    cmd = "arm-none-eabi-ld"
        ~ " -Tlinker/linker.ld"
        ~ " --gc-sections"
        ~ " " ~ objectFile
        ~ " -o " ~ outputFile;
    run(cmd);

    // display the size
    run("arm-none-eabi-size " ~ outputFile);
}
