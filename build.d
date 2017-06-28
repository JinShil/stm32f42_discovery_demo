#!/usr/bin/rdmd

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.process;
import std.stdio;

void run(string cmd)
{
    writeln(cmd);
    auto result = executeShell(cmd);
    writeln(result.output);
}

void main(string[] args)
{
    immutable auto compiler = "gdc";
    immutable auto linker = "ld";

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
    string cmd = "rm -f " ~ binaryDir ~ "/*";
    run(cmd);

    string sourceFiles = sourceDir
        .dirEntries("*.d", SpanMode.depth)
        .filter!(a => !a.name.startsWith("source/runtime")) // runtime will be imported automatically
        .map!"a.name"
        .join(" ");


    // compile to temporary assembly file
    cmd = "time " ~ compiler ~ " -m32 -c -O3 -nophoboslib -nostdinc -nodefaultlibs -nostdlib -fno-emit-moduleinfo"
          ~ " -Isource/runtime" // to import runtime automatically
          ~ " -fno-bounds-check -fno-invariants -fno-in -fno-out" // -fno-assert gives me a broken binary
          ~ " -ffunction-sections"
          ~ " -fdata-sections" 
          ~ " " ~ sourceFiles
          ~ " -o " ~ objectFile;                  
    run(cmd);
    
    // link, creating executable
    //cmd = "time " ~ linker ~ " " ~ objectFile ~ " -Tlinker/linker.ld --gc-sections -o " ~ outputFile;
    //run(cmd);
    
    // display the size
    run("size " ~ objectFile);
}
