module dmain2;

private alias extern(C) void function() MainFunc;

extern (C) int _d_run_main(int argc, char **argv, MainFunc mainFunc)
{
	mainFunc();
	return 0;
}