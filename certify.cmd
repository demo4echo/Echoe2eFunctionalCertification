@echo off

@REM Setup target version(s)
set KARATE_VERSION=0.9.3

@REM Run the Karate feature in the given folder (and sub folders)
java -jar lib/karate-%KARATE_VERSION%.jar src/test/karate
