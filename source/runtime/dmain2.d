module dmain2;

private alias extern(C) int function(char[][] args) MainFunc;

extern (C) int _d_run_main(int argc, char **argv, MainFunc mainFunc)
{
	char[][] args;
	return mainFunc(args);
}