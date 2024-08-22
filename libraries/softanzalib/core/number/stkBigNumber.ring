
# NOTE: this class was mostly in collaborationbetween ClaudeAI and ChatGPT


#---------#
#  CLASS  #
#---------#

class stkBigNumber
	@cIntPart
	@cFractPart
	@bIsNegative

    	def init(cValue)

	        if not isString(cValue)
	            	raise("ERR-" + StkError(:IncorrectParamType))
	        ok

		cValue = trim( substr(cValue, "_", "") )

		if not isNumber(0+ cValue)
			raise("ERR-" + StkError(:IncorrectParamType))
		ok

	        @bIsNegative = (left(cValue, 1) = "-")

	        if @bIsNegative
	            	cValue = substr(cValue, "-", "")
	        ok
	        
	        acParts = split(cValue, ".")
	        @cIntPart = This.pvtStripLeadingZeros(acParts[1])

	        if len(acParts) > 1
	            	@cFractPart = This.pvtStripTrailingZeros(acParts[2])
	        else
	            	@cFractPart = ""
	        ok
	        
	        if @cIntPart = "" and
		   @cFractPart = ""

	           	@cIntPart = "0"
	        ok

	def IntPart()
		return @cIntPart

		def SIntPart()
			return @cIntPart

	def FractPart()
		return @cFractPart

		def SFractPart()
			return @cFractPart

   	def Value()
        	result = @cIntPart

	        if @cFractPart != ""
	            result += "." + @cFractPart
	        ok

	        if @bIsNegative and result != "0"
	            result = "-" + result
	        ok

	        return result

		def SValue()
			return This.Value()

    	def Add(cOtherBigNumber)

		oOtherBigNumber = new stkBigNumber(cOtherBigNumber)

	        if @bIsNegative = oOtherBigNumber.isNegative()
	        	cResult = This.pvtAddDecimalStrings(SValue(), oOtherBigNumber.SValue())

	        else
		
			cResult = This.pvtSubtractDecimalStrings(This.SAbs(), oOtherBigNumber.SAbs())

			if @bIsNegative and This.pvtCompareAbsValues(This.SValue(), oOtherBigNumber.SValue()) > 0
				@bIsNegative = TRUE
			else
				@bIsNegative = FALSE
	            	ok

	        ok

		# Saving the number in two parts

		acParts = split(cResult, ".")
		nLen = len(acParts)

		@cIntPart = acParts[1]
	
		if nLen = 2
			@cFractPart = acParts[2]	
		ok

		def SAdd(cOtherBigNumber)
			This.Add(cOtherBigNumber)

    	def Subtract(cOtherBigNumber)

		oOtherBigNumber = new stkBigNumber(cOtherBigNumber)
	        oOtherBigNumber.SNegate()	
	        This.SAdd(oOtherBigNumber.SValue())

		def SSubtract(cOtherBigNumber)
			This.Subtract(cOtherBigNumber)


   	 def Multiply(cOtherBigNumber)

	   	oOtherBigNumber = new stkBigNumber(cOtherBigNumber)
	        cResult = This.pvtMultiplyDecimalStrings(This.SAbs(), oOtherBigNumber.SAbs())
	
	        if @bIsNegative != oOtherBigNumber.isNegative() and result != "0"
			@bIsNegative = TRUE
		else
			@bIsNegative = FALSE
	        ok

		# Saving the number in two parts

		acParts = split(cResult, ".")
		nLen = len(acParts)

		@cIntPart = acParts[1]
	
		if nLen = 2
			@cFractPart = acParts[2]	
		ok

		def SMultiply(cOtherBigNumber)
			This.Multiply(cOtherBigNumber)

	#---

	def Divide(cOtherBigNumber)
	    if cOtherBigNumber = "0"
	        raise("ERR-" + StkError(:DivisionByZero))
	    ok
	    
	    oOtherBigNumber = new stkBigNumber(cOtherBigNumber)
	    cResult = pvtDivideDecimalStrings(This.SAbs(), oOtherBigNumber.SAbs())
	    
	    # Determine if the result should be negative

	    if @bIsNegative != oOtherBigNumber.isNegative() and cResult != "0"
	        @bIsNegative = TRUE
	    else
	        @bIsNegative = FALSE
	    ok
	    
	    # Split the result into integer and fractional parts

	    acParts = split(cResult, ".")
	    nLen = len(acParts)
	    
	    # Ensure correct array access based on the length of the split result

	    if nLen >= 1
	        @cIntPart = pvtStripLeadingZeros(acParts[1])  # Assign the integer part
	    else
	        @cIntPart = "0"  # Fallback in case the split fails unexpectedly
	    ok
	    
	    if nLen = 2
	        @cFractPart = acParts[2]  # Assign the fractional part if it exists
	    else
	        @cFractPart = ""  # No fractional part
	    ok


		def SDivide(cOtherBigNumber, nPrecision)
			This.Divide(cOtherBigNumber, nPrecision)


	#---

   	 def isNegative()
        	return @bIsNegative

    	def SNegate()

        	if SValue() != "0"
            		@bIsNegative = not @bIsNegative
       		ok

       		return SValue()

		def Negate()
			return This.SNegate()

	def SAbs()
		if This.IsNegative()
			cResult = substr(This.SValue(), "-", "")
			return cResult
			
		else
			return This.SValue()
		ok


	#--------------------------------#
	PRIVATE // KITCHEN OF THE CLASS  #
	#--------------------------------#

	func pvtDivideDecimalStrings(s1, s2)

	    n1 = new stkBigNumber(s1)
	    n2 = new stkBigNumber(s2)
	    
	    # Align decimal points and prepare for division

	    decimalShift = max(len(n1.@cFractPart), len(n2.@cFractPart))
	    intPart1 = n1.@cIntPart + n1.@cFractPart + pvtCreateZeros(decimalShift - len(n1.@cFractPart))
	    intPart2 = n2.@cIntPart + n2.@cFractPart + pvtCreateZeros(decimalShift - len(n2.@cFractPart))
	    
	    # Ensure that intPart2 is not "0" to avoid infinite loops or division by zero

	    if intPart2 = "0"
	        raise("ERR-DivisionByZero")
	    ok
	    
	    # Perform long division

	    quotient = ""
	    remainder = "0"
	    dividendIndex = 1
	    decimalPointInserted = false
	    nLength = len(intPart1)
	    maxPrecision = 6  # Adjust this for desired precision
	    
	    while true

	        # Add the next digit to the remainder

	        if dividendIndex <= nLength
	            remainder += substr(intPart1, dividendIndex, 1)
	            dividendIndex++
	        else
	            remainder += "0"
	        ok
	        
	        # Normalize remainder by removing leading zeros

	        remainder = pvtStripLeadingZeros(remainder)
	        
	        # Calculate quotient digit

	        digit = 0

	        while pvtCompareStrings(remainder, intPart2) >= 0
	            remainder = pvtSubtractStrings(remainder, intPart2)
	            digit++
	        end

	        quotient += "" + digit
	        
	        # Insert decimal point if needed

	        if dividendIndex > nLength and not decimalPointInserted
	            quotient += "."
	            decimalPointInserted = true
	        ok
	        
	        # Stop if we've reached desired precision after decimal point

	        if decimalPointInserted and len(substr(quotient, substr(quotient, ".") + 1)) >= maxPrecision
	            break
	        ok
	        
	        # Stop if the quotient becomes too long (as a safeguard)

	        if len(quotient) > 100
	            break
	        ok
	    end
	    
	    # Strip trailing zeros in the fractional part

	    return pvtStripTrailingZeros(quotient)
	
	
	# Helper function to create a string of zeros

	func pvtCreateZeros(n)

	    result = ""

	    for i = 1 to n
	        result += "0"
	    next

	    return result
	

	######

	func pvtAddDecimalStrings(s1, s2)

	        n1 = new stkBigNumber(s1)
	        n2 = new stkBigNumber(s2)
	        maxFracLen = This.pvtMax(len(n1.@cFractPart), len(n2.@cFractPart))
	        n1Padded   = This.pvtPadRight(n1.@cIntPart + n1.@cFractPart, len(n1.@cIntPart) + maxFracLen, "0")
	        n2Padded   = This.pvtPadRight(n2.@cIntPart + n2.@cFractPart, len(n2.@cIntPart) + maxFracLen, "0")
	        
	        sum = This.pvtAddStrings(n1Padded, n2Padded)
	        
	        if len(sum) > maxFracLen
	            intPart = left(sum, len(sum) - maxFracLen)
	            fracPart = right(sum, maxFracLen)
	        else
	            intPart = "0"
	            fracPart = This.pvtPadLeft(sum, maxFracLen, "0")
	        ok
	        
	        cResult = This.pvtStripTrailingZeros(intPart + "." + fracPart)
		return cResult

   	 func pvtSubtractDecimalStrings(s1, s2)
	        n1 = new stkBigNumber(s1)
	        n2 = new stkBigNumber(s2)
	        maxFracLen = This.pvtMax(len(n1.@cFractPart), len(n2.@cFractPart))
	        n1Padded   = This.pvtPadRight(n1.@cIntPart + n1.@cFractPart, len(n1.@cIntPart) + maxFracLen, "0")
	        n2Padded   = This.pvtPadRight(n2.@cIntPart + n2.@cFractPart, len(n2.@cIntPart) + maxFracLen, "0")
	        
	        if pvtCompareAbsValues(s1, s2) < 0
	            diff = This.pvtSubtractStrings(n2Padded, n1Padded)
	            isNegative = true
	        else
	            diff = This.pvtSubtractStrings(n1Padded, n2Padded)
	            isNegative = false
	        ok
	        
	        diff     = This.pvtPadLeft(diff, len(n1Padded), "0")
	        intPart  = left(diff, len(diff) - maxFracLen)
	        fracPart = right(diff, maxFracLen)
	        
	        result = This.pvtStripLeadingZeros(intPart) + "." + This.pvtStripTrailingZeros(fracPart)
	        if isNegative and result != "0"
	            result = "-" + result
	        ok
	        
	        return result

    	func pvtCompareAbsValues(s1, s2)
	        n1 = new stkBigNumber(This.pvtSAbs(s1))
	        n2 = new stkBigNumber(This.pvtSAbs(s2))
	        
	        if n1.@cIntPart != n2.@cIntPart
	            return len(n1.@cIntPart) - len(n2.@cIntPart) or 
	                   This.pvtCompareStrings(n1.@cIntPart, n2.@cIntPart)
	        ok
	        
	        return This.pvtCompareStrings(n1.@cFractPart, n2.@cFractPart)
	
    	func pvtStripLeadingZeros(s)
	        while TRUE
			if NOT (left(s, 1) = "0" and len(s) > 1)
				exit
			ok

	            	s = substr(s, 2)
	        end

	        return s

    	func pvtStripTrailingZeros(s)

		while TRUE
			nLen = len(s)
			if nLen < 0
				exit
			ok
	
			if right(s, 1) != "0"
				exit
			ok
	
			s = left(s, nLen - 1)
	        end
	
		if right(s, 1) = "."
			s = left(s, nLen - 1)
		ok
		
	        return s

    	func pvtSAbs(s) # s is a number in string
	        if left(s, 1) = "-"
	            s = substr(s, "-", "")
	        ok
	        return s

 	func pvtPadLeft(s, n, char)
	        while len(s) < n
	            s = char + s
	        end
	        return s

	func pvtPadRight(s, n, char)
	        while len(s) < n
	            s = s + char
	        end
	        return s

    	func pvtShiftLeft(s, n)
        	return s + This.pvtCopy("0", n)

    	func pvtAddStrings(s1, s2)
	        result = ""
	        carry = 0
	
	        maxLen = This.pvtMax(len(s1), len(s2))
	        s1 = This.pvtPadLeft(s1, maxLen, "0")
	        s2 = This.pvtPadLeft(s2, maxLen, "0")
	        
	        for i = maxLen to 1 step -1
	            sum = 0+ (s1[i]) + s2[i] + carry
	            result = "" + (sum % 10) + result
	            carry = floor(sum / 10)
	        next
	 
	        if carry > 0
	            result = ""+ carry + result
	        ok
	        
	        return result

   	 func pvtSubtractStrings(s1, s2)
	        result = ""
	        borrow = 0
	        maxLen = This.pvtMax(len(s1), len(s2))
	        s1 = This.pvtPadLeft(s1, maxLen, "0")
	        s2 = This.pvtPadLeft(s2, maxLen, "0")
	        
	        for i = maxLen to 1 step -1
	            diff = 0+ s1[i] - s2[i] - borrow
	            if diff < 0
	                diff += 10
	                borrow = 1
	            else
	                borrow = 0
	            ok
	            result = ""+ diff + result
	        next
	        
	        return This.pvtStripLeadingZeros(result)

   	 func pvtCompareStrings(s1, s2)
	        maxLen = This.pvtMax(len(s1), len(s2))
	        s1 = This.pvtPadLeft(s1, maxLen, "0")
	        s2 = This.pvtPadLeft(s2, maxLen, "0")
	        
	        for i = 1 to maxLen
	            if s1[i] != s2[i]
	                return ascii(s1[i]) - ascii(s2[i])
	            ok
	        next
	        
	        return 0

	#-----

	func pvtMultiplyDecimalStrings(s1, s2)
		n1 = new stkBigNumber(s1)
	        n2 = new stkBigNumber(s2)
	        fracLen1 = len(n1.@cFractPart)
	        fracLen2 = len(n2.@cFractPart)
	        
	        int1 = n1.@cIntPart + n1.@cFractPart
	        int2 = n2.@cIntPart + n2.@cFractPart
	        
	        product = This.pvtKaratsubaMultiply(int1, int2)
	        totalFracLen = fracLen1 + fracLen2
	        
	        if len(product) > totalFracLen
	            intPart = left(product, len(product) - totalFracLen)
	            fracPart = right(product, totalFracLen)
	        else
	            intPart = "0"
	            fracPart = This.pvtPadLeft(product, totalFracLen, "0")
	        ok
	        
	        return This.pvtStripTrailingZeros(This.pvtStripLeadingZeros(intPart) + "." + fracPart)
	
   	func pvtKaratsubaMultiply(x, y)
	        # Base case for recursion
	        if len(x) < 10 or len(y) < 10
	            return ""+ ( (0+ x) * (0+ y))
	        ok
	
	        m = min(len(x), len(y))
	        m2 = floor(m / 2)
	
	        # Split the digit sequences about the middle
	        high1 = left(x, len(x) - m2)
	        low1  = right(x, m2)
	        high2 = left(y, len(y) - m2)
	        low2  = right(y, m2)
	
	        # 3 recursive calls made to numbers approximately half the size
	        z0 = This.pvtKaratsubaMultiply(low1, low2)
	        z1 = This.pvtKaratsubaMultiply(pvtAddStrings(low1, high1), pvtAddStrings(low2, high2))
	        z2 = This.pvtKaratsubaMultiply(high1, high2)
	
	        return This.pvtAddStrings(
	            This.pvtAddStrings(
	                This.pvtShiftLeft(z2, 2*m2),
	                This.pvtShiftLeft(This.pvtSubtractStrings(This.pvtSubtractStrings(z1, z2), z0), m2)
	            ),
	            z0
	        )

	func pvtCopy(s, n)
	
	        result = ""
	
	        for i = 1 to n
	            result += s
	        next
	
	        return result
	
	func pvtMin(a, b)
	
	        if a < b
	            return a
	        else
	            return b
	        ok

	func pvtMax(a, b)
	        if a < b
	            return b
	        else
	            return a
	        ok

	func pvtAppendZeros(str, n)
		for i = 1 to n
			str += "0"
		next
	    	return str
