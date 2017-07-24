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
		.filter!(a => !a.name.startsWith("source/runtime")) // runtime will be imported automatically
		.map!"a.name"
		.join(" ");

	
    // compile to temporary assembly file
    cmd = "arm-none-eabi-gdc -c -Os -nophoboslib -nostdinc -nodefaultlibs -nostdlib"
          ~ " -mthumb -mcpu=cortex-m4 -mtune=cortex-m4"
          ~ " -Isource/runtime" // to import runtime automatically
          ~ " -fno-bounds-check -fno-invariants -fno-in -fno-out" // -fno-assert gives me a broken binary          
          ~ " -ffunction-sections"
          ~ " -fdata-sections" 
          
          ~ " " ~ sourceFiles
          ~ " -o " ~ objectFile;                  
    run(cmd);
    
    // link, creating executable
    cmd = "arm-none-eabi-ld " ~ objectFile ~ " -Tlinker/linker.ld --gc-sections -o " ~ outputFile;
    run(cmd);
    
    // display the size
    run("arm-none-eabi-size " ~ outputFile);
}
