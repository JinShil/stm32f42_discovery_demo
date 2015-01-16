#!/usr/bin/rdmd

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.process;
import std.stdio;

void main(string[] args)
{
    auto sourceDir = "source";
    auto binaryDir = "binary";
    auto assemblyFile1 = buildPath(binaryDir, "firmware_temp.s");
    auto assemblyFile2 = buildPath(binaryDir, "firmware.s");
    auto objectFile = buildPath(binaryDir, "firmware.o");
    auto outputFile = buildPath(binaryDir, "firmware");
    
    // Create any directories that may not exist
    if (!binaryDir.exists())
    {
        mkdir(binaryDir);
    }
    
    string cmd = "rm -f " ~ outputFile;
    system(cmd);

    cmd = "arm-none-eabi-gdc -c -O3 -nophoboslib -nostdinc -nodefaultlibs -nostdlib -fno-emit-moduleinfo -ffunction-sections -fdata-sections"
          ~ " -S"
          ~ " " ~ sourceDir.dirEntries("*.d", SpanMode.depth).map!"a.name".join(" ")
          //~ " -Wl,-Tsource/linker/linker.ld -Wl,--gc-sections"
          ~ " -o " ~ assemblyFile1;                  
            
    writeln(cmd);
    system(cmd);
    
    cmd = `sed -e 's/^\(\.LC[0-9]*\)\(\:\)/\.section .rodata\1\n\1\2/g' ` ~ assemblyFile1 ~ " >" ~ assemblyFile2;
    writeln(cmd);
    system(cmd);
    
    cmd = "arm-none-eabi-as " ~ assemblyFile2 ~ " -o " ~ objectFile;
    writeln(cmd);
    system(cmd);
    
    cmd = "arm-none-eabi-ld " ~ objectFile ~ " -Tsource/linker/linker.ld --gc-sections -o " ~ outputFile;
    writeln(cmd);
    system(cmd);
    
    system("arm-none-eabi-size " ~ outputFile);
}