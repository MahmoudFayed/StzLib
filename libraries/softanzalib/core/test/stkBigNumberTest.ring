
load "../Common/stkRingLibs.ring"

load "../common/stkNumberCommons.ring"
load "../number/stkBigNumber.ring"

load "../error/stkError.ring"

decimals(3)
t0 = clock()


/*-------

oBig = new stkBigNumber("324987182091876345.078")

oBig.Divide("876234987333.9876673")
	? oBig.SValue()
	#--> 370890.442392
	? oBig.Round() + NL
	#--> 6

oBig = new stkBigNumber("1.5")
	oBig.Divide("0.3")
	? oBig.SValue()
	#--> 5
	? oBig.Round() + NL
	#--> 0

oBig = new stkBigNumber("1")
	oBig.Divide("3")
	? oBig.SValue()
	#--> 0.333333
	? oBig.Round() + NL
	#--> 6

oBig = new stkBigNumber("795139556375158458500672312034291657065.10336")
	oBig.Divide("876234987333.9876673")
	? oBig.SValue()
	#--> 907450133661555453466475424.407391
	? oBig.Round() + NL
	#--> 6

oBig = new stkBigNumber("124_280_400.68")
	oBig.Divide("2")
	? oBig.SValue()
	#--> 62140200.34
	? oBig.Round()
	2

# Executed in 0.024 seconds.

/*-------

oBig = new stkBigNumber("324_987_182_091_876_345.078")

? oBig.SValue()
	#--> 324987182091876345.078
	? oBig.Round() + NL
	#--> 3

oBig.Add("122_333_987_337_132_339.987653")
	? oBig.SValue()
	#--> 447321169429008685.065653
	? oBig.Round() + NL
	#--> 6

oBig.Subtract("122_333_987_337_132_339.987653")
	? oBig.SValue()
	#--> 324987182091876345.078
	? oBig.Round() + NL
	#--> 3

oBig.Multiply("122_333_987_337_132_339.987653")
	? oBig.SValue()
	#--> 39756977818757922769007316455505225.287321934
	? oBig.Round() + NL
	#--> 9

oBig.Multiply("2")
	? oBig.SValue()
	#--> 795139556375158458500672312034291657065.10336
	? oBig.Round() + NL
	#--> 5

oBig.Divide("2")
	? oBig.SValue()
	#--> 397569778187579229250336156017145828532.55168
	? oBig.Round() + NL
	#--> 5

# Executed in 0.026 seconds.

/*-------

oBig = new stkBigNumber("795139556375158458500672312034291657065.10336")

	oBig.Divide("876234987333.9876673")
	? oBig.SValue()
	#--> 907450133661555453466475424.407391
	? oBig.Round() + NL
	#--> 6

	? oBig.Rounded(2) + NL
	#--> 907450133661555453466475424.41

	? oBig.Rounded(4) + NL
	#--> 907450133661555453466475424.4074

	? oBig.Rounded(5) + NL
	#--> 907450133661555453466475424.40739

	? oBig.Rounded(6) + NL
	#--> 907450133661555453466475424.407391

	? oBig.Rounded(1) + NL
	#--> 907450133661555453466475424.4

oBig = new stkBigNumber("123_456_789.87")

	? oBig.Rounded(1)
	#--> 123456789.9

	? oBig.Rounded(0) + NL
	#--> 123456790

oBig = new stkBigNumber("123_456_789")
	? oBig.RoundedTo(0)
	#--> 123456789

	? oBig.RoundedTo(1)
	#--> 123456789.0

	? oBig.RoundedTo(3)
	#--> 123456789.000

# Executed in 0.013 seconds.

/*--------- #narration

# stkBigNumber has 3 important criterias regarding rounding:
#	1. It maintains both the current value and the initial value (before any rounding).
#	2. It has methods for both viewing a rounded value (RoundedTo), without modifying
# 	   the number, and actually rounding the number (RoundTo) and thus modifiying it.
# 	3. It keeps track of the current precision (current round) separately from the full
# 	   precision of the initial value.

# Let's check this by example.

# Create a new stkBigNumber object with a large negative number

oBig = new stkBigNumber("-12_345_567_980_117.8765454")

	# Display the current precision of the number

	? oBig.Precision()
	#--> 7
	
	# Display the number rounded to 3 decimal places without changing the original

	? oBig.RoundedTo(3)
	#--> -12345567980117.877
	
	# Verify that the original precision hasn't changed

	? oBig.Precision()
	#--> 7
	
	# Round the number to 3 decimal places and modify the original object

	oBig.RoundTo(3)
	
	# Display the new value of the number after rounding

	? oBig.SValue()
	#--> -12345567980117.877
	
	# Verify that the precision has been updated to 3

	? oBig.Precision()
	#--> 3
	
	# Display the initial value of the number (before any rounding)

	? oBig.SInitialValue()
	#--> -12345567980117.8765454
	
	# Display the full precision of the initial value

	? oBig.FullPrecision()
	#--> 7

# Executed in 0.001 seconds.

/*------


oBig = new stkBigNumber("-123_456_789")
	? oBig.RoundedTo(0) + NL
	#--> -123456789

/*------ #narration

# This code demonstrates the flexibility of the stkBigNumber class
# in handling different precision levels. It shows how to:

# 1. Check and use maximum and default precision settings.
# 2. Create a BigNumber with a specific value.
# 3. View and modify the precision of the number.
# 4. Access the full precision of the original number.
# 5. Use symbolic precision settings (:Max and :Default).
# 6. Restore the number to its original state.
# 7. Observe how different precision settings affect the displayed value.

# The class maintains the original value while allowing for different
# representations based on the specified precision, providing a powerful
# tool for numeric operations requiring varying levels of precision.

# Display the maximum allowed precision for BigNumber

? BigNumberMaxPrecision()
#--> 28

# Display the default precision for BigNumber

? BigNumberDefaultPrecision() + NL
#--> 6

# Create a new BigNumber object

oBig = new stkBigNumber("12_345_549.878546")

# Display the current precision of the number (defaults to 6)

? oBig.Precision() # Or Round()
#--> 6

# Set the precision to 2 decimal places

oBig.SetPrecision(2) # Or SetRound()

# Display the value after setting precision

? oBig.SValue()
#--> 12345549.88

# Display the full precision of the original number

? oBig.FullPrecision() # Or FullRound()
#--> 6

# Set the precision to the maximum allowed

oBig.SetPrecision(:Max)

# Display the new precision

? oBig.Precision()
#--> 28

# Display the value with maximum precision

? oBig.SValue()
#--> 12345549.8800000000000000000000000000

# Restore the number to its original state

oBig.Restore()

# Set the precision to the default value

oBig.SetPrecision(:Default)

# Display the new precision

? oBig.Precision()
#--> 6

# Display the value with default precision

? oBig.SValue()
#--> 12345549.878546

# Set the precision back to 2 decimal places

oBig.SetPrecision(2)

# Display the final value

? oBig.SValue()

#--> 12345549.88

# Executed in 0.001 seconds.

/*------------

oBig = new stkBigNumber("324987182091876345.078")
? oBig.Spacified()
#--> 324_987_182_091_876_345.078

oBig = new stkBigNumber("-11177875676436736363572788363.98")
? oBig.Spacified()
#--> -11_177_875_676_436_736_363_572_788_363.98

/*------------

# stkBigNumber has a nice spacification feature.
# Let's explore it with example

oBig = new stkBigNumber("-12500277113.9887")

	# The spacification concerns only the integer part

	? oBig.IntPart()
	#--> -12500277113

	? oBig.IntPartSpacified()
	#--> -12_500_277_113

	? ""

	# Usually, you would rather experience spacification
	# when you get the value of the number:

	# So, by default, the number is not spacified:

	? oBig.SValue()
	#--> -12500277113.9887

	# But you can spacify it:

	oBig.Spacify()

	? oBig.SValue()
	#--> -12_500_277_113.9887

	# and unspacify it, at will:

	oBig.Unspacify()

	? oBig.SValue()
	#--> -12500277113.9887

? " "

# If the number is provided with spacification,
# then the output are also spacified:

oBig = new stkBigNumber("12_549_334_289.0987")

	? oBig.SValue()
	#--> 12_549_334_289.0987

# As we saw, you can turn it off:

	oBig.Unspacify()
	? oBig.SValue()
	#--> 12549334289.0987

# And turn it on again:

	oBig.Spacify()
	? oBig.SValue()
	#--> 12_549_334_289.0987

/*======= #ai These tests where proposed by @chatgpt

# Addition Test with Large Numbers

oBig = new stkBigNumber("999_999_999_999_999_999.999")
oBig.Add("1")
? oBig.SValue()
#--> 1_000_000_000_000_000_000.999
? oBig.Round() + NL
#--> 3

# Executed in 0.002 seconds.

/*--------

# Subtraction Test with Negative Results

oBig = new stkBigNumber("1_000_000.000")

oBig.Subtract("2_000_000.000")
? oBig.SValue()
#--> -1_000_000
? oBig.Round() + NL
#--> 0

# Executed in 0.002 seconds.

/*--------

# Multiplication Test with Multiple Rounding Scenarios

oBig = new stkBigNumber("-12_345.6789")
oBig.Multiply("98_765.4321")
? oBig.SValue()
#--> -1_219_326_311.12635264
? oBig.Round() + NL
#--> 8

# Executed in 0.002 seconds.

/*--------

# Division Test with Precision Edge Cases

oBig = new stkBigNumber("1.000000")
oBig.Divide("3")
? oBig.SValue()
#--> 0.333333
? oBig.Rounded(5) + NL
#--> 0.33333
? oBig.Rounded(10) + NL
#--> 0.3333330000

# Executed in 0.002 seconds.

/*--------

# Rounding Test with Large Negative Numbers

oBig = new stkBigNumber("-987_654_321.123456789")
oBig.RoundTo(4)
? oBig.SValue()
#--> -987_654_321.1235.1235

# Executed in less than 0.001 seconds.

/*--------

	# Precision Adjustment Test
	
	? 999.999999
	#--> 1000.000
	
	oBig = new stkBigNumber("999.999999")
	oBig.SetPrecision(2)
	? oBig.SValue()
	#--> 999.10

/*--------

# Spacification with Various Formats

oBig = new stkBigNumber("123456789.987654321")
? oBig.Spacified()
#--> 123_456_789.987654321

oBig.Spacify()
? oBig.SValue()
#--> 123_456_789.987654321

oBig.Unspacify()
? oBig.SValue()
#--> 123456789.987654321

# Executed in less than 0.001 seconds.

/*--------

# Restoration After Precision Change

oBig = new stkBigNumber("987654321.123456789")
oBig.SetPrecision(5)
? oBig.SValue()
#--> 987654321.12346

oBig.Restore()
? oBig.SValue()
#--> 987654321.123456789

# Executed in less than 0.001 seconds.

/*--------

# Testing with Symbols for Precision Settings

oBig = new stkBigNumber("12345.6789")
oBig.SetPrecision(:Max)
? oBig.SValue()
#--> 12345.6789000000000000000000000000
? oBig.Round()
#--> 28

oBig.SetPrecision(:Default)
? oBig.SValue()
#--> 12345.6789
? oBig.Round()
#--> 6

# Executed in less than 0.001 seconds.

/*--------
*/
# Testing with Special Cases

oBig = new stkBigNumber("0")
oBig.Add("0")
? oBig.SValue()
#--> 0

oBig = new stkBigNumber("999999999999999999999999999999999999999")
oBig.Multiply("9999999999999_99999999999999999999999999")
? oBig.SValue()
#--> 999_999_999_999_999_999_999_999_999_999_999_999_998_000_000_000_000_000_000_000_000_000_000_000_001
#--> 999,999,999,999,999,999,999,999,999,999,999,999,998,000,000,000,000,000,000,000,000,000,000,000,000,001

#--> 999_999_999_999_999_999_999_999_999_999_999_999_997_999_999_999_990_000_000_010_000_000_001_000_000_000
#--> 999,999,999,999,999,999,999,999,999,999,999,999,998,000,000,000,000,000,000,000,000,000,000,000,000,001

/*~~~~~~~~~~~~
*/
? NL + "~~~~~~~~~" + NL
? "Executed in " + (clock() - t0) / clockspersecond() + " seconds."
