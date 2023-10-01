

	  #============================================================================#
	 #  CHECKING IF THE STRING CONTAINS A SBISTRING BETWEEN TWO OTHER SUBSTRINGS  #
	#============================================================================#

	def ContainsSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		# Checking params

		if CheckParams()
			if NOT BothAreStrings(pcBound1, pcBound2)
				StzRaise("Incorrect params types! pcBound1 and pcBound2 must be both strings.")
			ok
		ok

		# Finding the substring as sections

		aSections = This.FindSubStringAsSectionsCS(pcSubStr, pCaseSensitive)

		nLen = len(aSections)
		nLenBound1 = Q(pcBound1).NumberOfChars()
		nLenBound2 = Q(pcBound2).NumberOfChars()

		# Looping over the sections and checking wether their bounds
		# correspond to pcBound1 and pcBound2

		bResult = FALSE

		cBound1 = pcBound1
		cBound2 = pcBound2

		if IsCaseSensitive(pCaseSensitive)
			cBound1 = Q(pcBound1).Lowercased()
			cBound2 = Q(pcBound2).Lowercased()
		ok

		for i = 1 to nLen
			
			acBounds = This.SectionBounds(aSections[1], aSections[2], nLenBound1, nLenBound2)

			if acBounds[1] = cBound1 and acBounds[2] = cBound2

				bResult = TRUE
				exit

			ok

		next

		return bResult

		#< @FunctionAlternativeForms

		def ContainsSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.ContainsSubStringBetweenCS(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.This.ContainsSubStringBetweenCS(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be string or a pair of strings.")
			ok

		def ContainsBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.ContainsSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def ContainsBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.ContainsSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVE

	def ContainsSubStringBetween(pcSubStr, pcBound1, pcBound2)
		return This.ContainsSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def ContainsSubStringBoundedBy(pcSubStr, pacBounds)
			return This.ContainsSubStringBetween(pcSubStr, pcBound1, pcBound2)

		def ContainsBetween(pcSubStr, pcBound1, pcBound2)
			return This.ContainsSubStringBetween(pcSubStr, pcBound1, pcBound2)

		def ContainsBoundedBy(pcSubStr, pacBounds)
			return This.ContainsBoundedByCS(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#>

	   #------------------------------------------------------------#
	  #  CHECKING IF THE STRING CONTAINS A SBISTRING BETWEEN TWO   #
	 #  OTHER SubString STARTING AT A GIVEN POSITION              #
	#------------------------------------------------------------#

	def ContainsSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nLast = This.NumberOfChars()
		bResult = This.SectionQ(pnStartingAt, nLast).ContainsSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		return bResult

		def ContainsSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.ContainsSubStringBetweenSCS(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.This.ContainsSubStringBetweenCSContainsSubStringBetweenSCS(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be string or a pair of strings.")
			ok

	#-- WITHOUT CASESENSITIVITY

	def ContainsSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.ContainsSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive) = TRUE

		def ContainsSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.ContainsSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

	  #------------------------------------------------------------------------------------#
	 #  GETTING THE NUMBER OF OCCURRENCES OF A SUBSTRING BOUBDED BY TWO OTHER SUBSTRINGS  #
	#------------------------------------------------------------------------------------#

	def NumberOfOccurrenceBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nResult = len( This.FindSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive) )
		return nResult

		#< @FunctionAlternativeForms

		def NumberOfOccurrenceBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.NumberOfOccurrenceBetweenCS(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NumberOfOccurrenceBetweenCS(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		def NumberOfOccurrenceOfSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.NumberOfOccurrenceBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def NumberOfOccurrenceOfSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.NumberOfOccurrenceBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)

		#-- Occurrences (with s)
	
		def NumberOfOccurrencesBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.NumberOfOccurrenceBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def NumberOfOccurrencesBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.NumberOfOccurrenceBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)

		def NumberOfOccurrencesOfSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.NumberOfOccurrenceBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def NumberOfOccurrencesOfSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.NumberOfOccurrenceBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def NumberOfOccurrenceBetween(pcSubStr, pcBound1, pcBound2)
		return This.NumberOfOccurrenceBetweenCS(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def NumberOfOccurrenceBoundedBy(pcSubStr, pacBounds)
			return This.NumberOfOccurrenceBoundedByCS(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		def NumberOfOccurrenceOfSubStringBetween(pcSubStr, pcBound1, pcBound2)
			return This.NumberOfOccurrenceBetween(pcSubStr, pcBound1, pcBound2)

		def NumberOfOccurrenceOfSubStringBoundedBy(pcSubStr, pacBounds)
			return This.NumberOfOccurrenceBoundedByCS(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#-- Occurrences (with s)
	
		def NumberOfOccurrencesBetween(pcSubStr, pcBound1, pcBound2)
			return This.NumberOfOccurrenceBetween(pcSubStr, pcBound1, pcBound2)

		def NumberOfOccurrencesBoundedBy(pcSubStr, pacBounds)
			return This.NumberOfOccurrenceBoundedByCS(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		def NumberOfOccurrencesOfSubStringBetween(pcSubStr, pcBound1, pcBound2)
			return This.NumberOfOccurrenceBetween(pcSubStr, pcBound1, pcBound2)

		def NumberOfOccurrencesOfSubStringBoundedBy(pcSubStr, pacBounds)
			return This.NumberOfOccurrenceBoundedByCS(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#>

	   #---------------------------------------------------------------#
	  #  GETTING THE NUMBER OF OCCURRENCES OF A SUBSTRING BOUBDED BY  #
	 #  TWO OTHER SUBSTRINGS STARTING AT A GIVEN POSITION            #
	#---------------------------------------------------------------#

	def NumberOfSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		nResult = len( This.FindSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt) )
		return nResult

		#< @FunctionAlternativeForms

		def NumberOfOccurrenceBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.NumberOfSubStringBetweenSCS(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NumberOfSubStringBetweenSCS(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		def NumberOfOccurrenceOfSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NumberOfSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NumberOfOccurrenceOfSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.NumberOfOccurrenceBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
	
		#-- Occurrences (with s)
	
		def NumberOfOccurrencesBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NumberOfSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NumberOfOccurrencesBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.NumberOfOccurrenceBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NumberOfOccurrencesOfSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NumberOfSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NumberOfOccurrencesOfSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.NumberOfOccurrenceBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def NumberOfSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NumberOfSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def NumberOfOccurrenceBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.NumberOfOccurrenceBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def NumberOfOccurrenceOfSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NumberOfSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NumberOfOccurrenceOfSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.NumberOfOccurrenceBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)
	
		#-- Occurrences (with s)
	
		def NumberOfOccurrencesBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NumberOfSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NumberOfOccurrencesBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.NumberOfOccurrenceBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def NumberOfOccurrencesOfSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NumberOfSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NumberOfOccurrencesOfSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
				return This.NumberOfOccurrenceBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		#>

	   #----------------------------------------------------------------------#
	  #  CHECKING IF THE STRING CONTAINS N OCCURRENCES OF A GIVEN SUBSTRING  #
	 #  BOUNDED BY TWO OTHER SUBSTRINGS                                      #
	#----------------------------------------------------------------------#

	def ContainsNOccurrencesOfSubStringBetweenCS(n, pcBound1, pcBound2, pCaseSensitive)
		bResult = ( This.NumberOfOccurrenceBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive) = n )
		return bResult

		def ContainsNOccurrencesOfSubStringBoundedByCS(n, pacBounds, pCaseSenstive, pCaseSensitive)
			if isString(pacBounds)
				return This.ContainsNOccurrencesOfSubStringBetweenCS(n, pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.ContainsNOccurrencesOfSubStringBetweenCS(n, pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

	#-- WITHOUT CASESENSITIVITY

	def ContainsNOccurrencesOfSubStringBetween(n, pcBound1, pcBound2)
		return This.ContainsNOccurrencesOfSubStringBetweenCS(n, pcBound1, pcBound2, :CaseSensitive = TRUE)

		def ContainsNOccurrencesOfSubStringBoundedBy(n, pacBounds)
			return This.ContainsNOccurrencesOfSubStringBoundedByCS(n, pacBounds, pCaseSenstive, :CaseSensitive = TRUE)

	   #-----------------------------------------------------------------------#
	  #  CHECKING IF THE STRING CONTAINS N OCCURRENCES OF A GIVEN SUBSTRING   #
	 #  BOUNDED BY TWO OTHER SUBSTRINGS STARTING AT A GIVEN POSITION          #
	#-----------------------------------------------------------------------#

	def ContainsNOccurrencesOfSubStringBetweenSCS(n, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		bResult = ( This.NumberOfSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt) = n )
		return bResult

		def ContainsNOccurrencesOfSubStringBoundedBySCS(n, pacBounds, pnStartingAt, pCaseSensitive)
			return This.ContainsNOccurrencesOfSubStringBetweenSCS(n, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ContainsNOccurrencesOfSubStringBetweenS(n, pcBound1, pcBound2, pnStartingAt)
		return This.ContainsNOccurrencesOfSubStringBetweenSCS(n, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		def ContainsNOccurrencesOfSubStringBoundedByS(n, pacBounds, pnStartingAt)
			return This.ContainsNOccurrencesOfSubStringBetweenS(n, pcBound1, pcBound2, pnStartingAt)

	  #======================================================================#
	 #  FINDING OCCURRENCES OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	#======================================================================#

	def FindSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		/* EXAMPLE 1:

		o1 = new stzString("bla bla <<word>> bla bla <<noword>> bla <<word>>")
		? o1.FindSubStringBetweenCS("word", "<<", ">>", :CaseSensitive = FALSE)
		#--> [ 9, 41 ]

		EXAMPLE 2:

		o1 = new stzString("12*A*67*A*")
		? o1.FindSubStringBetween("A", "*", "*")
		#--> [4, 9]

		*/

		# Checking params

		if CheckParams()
			if NOT isString(pcSubStr)
				StzRaise("Incorrect param type! pcSubStr must be a string.")
			ok
	
			if NOT isString(pcBound1)
				StzRaise("Incorrect param type! pcBound1 must be a string.")
			ok
	
			if isList(pcBound2) and Q(pcBound2).IsAndNamedParam()
				pcBound2 = pcBound2[2]
			ok
	
			if NOT isString(pcBound2)
				StzRaise("Incorrect param type! pcBound2 must be a string.")
			ok
		ok

		# Doing the job

		nLenBound1 = Q(pcBound1).NumberOfChars()

		anPos = This.FindAllCS( pcBound1 + pcSubStr + pcBound2, pCaseSensitive )

		anResult = []

		if len(anPos) > 0
			anResult = QR(anPos, :stzListOfNumbers).AddedToEach(nLenBound1)
		ok

		return anResult

		#< @FunctionAlternativeForms

		def FindSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindSubStringBetweenCS(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindSubStringBetweenCS(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindSubStringBoundedByCSZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindSubStringBoundedByCS(pcSubStr, pacBound, pCaseSensitives)
	
		#--

		def SubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def SubstringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVE

	def FindSubstringBetween(pcSubStr, pcBound1, pcBound2)
		return This.FindSubStringSubStringBetweenCS(pcSubStr, pcBound1, pcBound1, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindSubStringBoundedBy(pcSubStr, pacBounds)
			return This.FindSubStringBoundedByCS(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#==

		def FindSubStringBetweenZ(pcSubStr, pcBound1, pcBound2)
			return This.SubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindSubStringBoundedByZ(pcSubStr, pacBounds)
			return This.SubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
	
		#--

		def SubStringBetween(pcSubStr, pcBound1, pcBound2)
			return This.FindSubStringBetween(pcSubStr, pcBound1, pcBound2)

		def SubstringBoundedBy(pcSubStr, pacBounds)
			return This.FindSubStringBoundedBy(pcSubStr, pacBounds)

		#>

	  #------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS POSITIONS BETWEEN TWO GIVEN SUBSTRINGS  #
	#------------------------------------------------------------------------#

	def SubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.FindSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def SubStringBoundedByCSZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.SubStringBetweenCSZ(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.SubStringBetweenCSZ(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def SubStringBetweenZ(pcSubStr, pcBound1, pcBound2)
		return This.SubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def SubStringBoundedByZ(pcSubStr, pacBounds)
			return This.SubStringBoundedByCSZ(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#>

	   #-------------------------------------------------------#
	  #  FINDING A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  AND RETURNING THEM AS SECTIONS                       #
	#=======================================================#

	def FindSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		anPos = This.FindSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nLenStr = Q(pcSubStr).NumberOfChars()
		nLenPos = len(anPos)

		aResult = []

		for i = 1 to nLenPos
			aResult + [ anPos[i], anPos[i] + nLenStr - 1 ]
		next

		return aResult

		#< @FunctionAlternativeForms

		def FindSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindSubStringBetweenCSZZ(pcSubStr, pcBounds, pcBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindSubStringBetweenCSZZ(pcSubStr, pcBounds[1], pcBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindSubStringBetweenAsSectionsCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindSubStringBoundedByAsSectionsCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)


		#>

	#-- WITHOUT CASESENSITIVITY

	def FindSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)
		return This.FindSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindSubStringBoundedByZZ(pcSubStr, pacBounds)
			return This.FindSubStringBoundedByZZ(pcSubStr, pacBounds)

		#--
	
		def FindSubStringBetweenAsSections(pcSubStr, pcBound1, pcBound2)
			return This.FindSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)

		def FindSubStringBoundedByAsSections(pcSubStr, pacBounds)
			return This.FindSubStringBoundedByZZ(pcSubStr, pacBounds)

		#>

	  #------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS SECTIONS BETWEEN TWO GIVEN SUBSTRINGS  #
	#-----------------------------------------------------------------------#

	def SubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.FindSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def SubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.SubStringBetweenCSZZ(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.SubStringBetweenCSZZ(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def SubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)
		return This.SubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def SubStringBoundedByZZ(pcSubStr, pacBounds)
			return This.SubStringBoundedByCSZZ(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#>

	  #------------------------------------------------------------------------#
	 #  FINDING A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS INCLUDING BOUNDS  #
	#========================================================================#

	def FindSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		anPos = This.FindSubStringsBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nLen = len(anPos)

		nLenBound1 = Q(pcBound1).NumberOfChars()

		anResult = []
		for i = 1 to nLen
			anResult = anPos[i] - nLenBound1
		next

		return anResult

		#< @FunctionAlternativeForms

		def FindSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindSubStringBetweenCSIB(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindSubStringBetweenCSIB(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindSubStringBoundedByCSIB(pcSubStr, pacBound, pCaseSensitives)

		#==

		def SubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def SubstringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
	
		#>

	#-- WITHOUT CASESENSITIVE

	def FindSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)
		return This.FindSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindSubStringBoundedByIB(pcSubStr, pacBounds)
			if isString(pacBounds)
				return This.FindSubStringBetweenIB(pcSubStr, pacBounds, pacBounds)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindSubStringBetweenIB(pcSubStr, pacBounds[1], pacBounds[2])

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindSubStringBetweenZIB(pcSubStr, pcBound1, pcBound2)
			return This.FindSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)

		def FindSubStringBoundedByZIB(pcSubStr, pacBounds)
			return This.FindSubStringBoundedByIB(pcSubStr, pacBounds)

		#==

		def SubStringBetweenIB(pcSubStr, pcBound1, pcBound2)
			return This.FindSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)

		def SubstringBoundedByIB(pcSubStr, pacBounds)
			return This.FindSubStringBoundedByIB(pcSubStr, pacBounds)
	
		#>

	  #-----------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS POSITIONS BETWEEN TWO GIVEN SUBSTRINGS INCLUDING BOUNDS  #
	#-----------------------------------------------------------------------------------------#

	def SubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.FindSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def SubStringBoundedByCSIBZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.SubStringBetweenCSIBZ(pcSubStr, pacBound, pacBound, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.SubStringBetweenCSIBZ(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def SubStringBetweenIBZ(pcSubStr, pcBound1, pcBound2)
		return This.SubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def SubStringBoundedByIBZ(pcSubStr, pacBounds)
			return This.SubStringBoundedByCSIBZ(pcSubStr, pacBounds, :CaseSensitive = TRUE)
		#>

	   #---------------------------------------------------------------#
	  #  FINDING A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS          #
	 #  INCLUDING BOUNDS AND RETURNING THEIR POSITIONS AS SECTIONS   #                                    #
	#===============================================================#

	def FindSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aSections = This.FindSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nLen = len(aSections)
		nLenBound1 = Q(pcBound1).NumberOfChars()
		nLenBound2 = Q(pcBound2).NumberOfChars()

		aResult = []

		for i = 1 to nLen
			n1 = aSections[i][1] - nLenBound1 + 1
			n2 = aSections[i][2]  + nLenBound2
			aResult + [ n1, n2 ]
		next

		return aResult

		#< @FunctionAlternativeForms

		def FindSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindSubStringBetweenCSIBZZ(pcSubStr, pcBounds, pcBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindSubStringBetweenCSIBZZ(pcSubStr, pcBounds[1], pcBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindSubStringBetweenAsSectionsCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindSubStringBoundedByAsSectionsCSIB(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)
		return This.FindSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindSubStringBoundedByIBZZ(pcSubStr, pacBounds)
			return This.FindSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		#--
	
		def FindSubStringBetweenAsSectionsIB(pcSubStr, pcBound1, pcBound2)
			return This.FindSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def FindSubStringBoundedByAsSectionsIB(pcSubStr, pacBounds)
			return This.FindSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		#>

	  #----------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS SECTIONS BETWEEN TWO GIVEN SUBSTRINGS INCLUDING BOUNDS  #
	#----------------------------------------------------------------------------------------#

	def SubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.FindSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def SubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.SubStringBetweenCSIBZZ(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.SubStringBetweenCSIBZZ(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def SubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)
		return This.SubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def SubStringBoundedByIBZZ(pcSubStr, pacBounds)
			return This.SubStringBoundedByCSIBZZ(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#>

	   #-------------------------------------------------------#
	  #  FINDING A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  STARTING AT A GIVEN POSITION                         #
	#=======================================================#

	def FindSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		nLast = This.NumberOfChars()
		anPos = This.SectionQ(pnStartingAt, nLast).FindSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nLen = len(anPos)

		anResult = []

		for i = 1 to nLen
			anResult + ( anPos[i] + pnStartingAt - 1 )
		next

		return anResult

		#< @FunctionalternativeForms

		def FindSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindSubStringBetweenSCS(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindSubStringBetweenSCS(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindSubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def SubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def SubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindSubStringBetweenSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindSubStringBoundedBySZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#==

		def SubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def SubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#>

	  #-----------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS POSITIONS BETWEEN TWO GIVEN SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#-----------------------------------------------------------------------------------------------------#

	def SubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult
		
		#< @FunctionAlternativeForm

		def SubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.SubStringBetweenSCSZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.SubStringBetweenSCSZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def SubStringBetweenSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		aResult = [ pcSubStr, This.FindSubStringBetweenSZ(pcSubStr, pcBound1, pcBound2) ]
		return aResult
		
		#< @FunctionAlternativeForm

		def SubStringBoundedBySZ(pcSubStr, pacBounds, pnStartingAt)
			return This. SubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		#>

	   #-------------------------------------------------------------------#
	  #  FINDING A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS STARTING AT  #
	 #  A GIVEN POSITION AND RETURNING POSITIONS AS SECTIONS             #
	#===================================================================#

	def FindSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		anPos = This.FindSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nLen = len(anPos)
		nLenStr = Q(pcSubStr).NumberOfChars()

		aResult = []

		for i = 1 to nLen
			aResult + [ anPos[i], (anPos[i] + nLenStr - 1) ]
		next

		return aResult

		#< @FunctionAlternativeForms

		def FindSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindSubStringBetweenSCSZZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).isPairOfStrings()
				return This.FindSubStringBetweenSCSZZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindSubStringBetweenAsSectionsSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindSubStringBoundedByAsSectionsSCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def SubStringBetweenAsSectionsSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def SubStringBoundedByAsSectionsSCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#--

	def FindSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindSubStringBetweenAsSectionsS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindSubStringBoundedByAsSectionsS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#==

		def SubStringBetweenAsSectionsS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def SubStringBoundedByAsSectionsS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#>

	  #----------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS SECTIONS BETWEEN TWO GIVEN SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#----------------------------------------------------------------------------------------------------#

	def SubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult
		
		#< @FunctionAlternativeForm

		def SubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.SubStringBetweenSCSZZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.SubStringBetweenSCSZZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def SubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.SubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def SubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.SubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		#>

	   #-------------------------------------------------------#
	  #  FINDING A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  STARTING AT A GIVEN POSITION AND INCLUDING BOUNDS    #
	#=======================================================#

	def FindSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		anPos = This.FindSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nLen = len(anPos)
		nLenStr = Q(pcSubStr).NumberOfChars()

		anResult = []

		for i = 1 to nLen
			anResult + ( anPos[i] - nLenStr + 1 )
		next

		return anResult

		#< @FunctionAlternativeForms

		def FindSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindSubStringBetweenSCSIB(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindSubStringBetweenSCSIB(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindSubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindSubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def SubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def SubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindSubStringBetweenSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindSubStringBoundedBySIBZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#==

		def SubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def SubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#>

	  #---------------------------------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS PSOTITIONS BETWEEN TWO GIVEN SUBSTRINGS STARTING AT A GIVEN POSITION AND INCLUDING BOUNDS  #
	#---------------------------------------------------------------------------------------------------------------------------#

	def SubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult
		
		#< @FunctionAlternativeForm

		def SubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.SubStringBetweenSCSIBZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.SubStringBetweenSCSIBZ(pcSubStr, pacBouns[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def SubStringBetweenSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.SubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def SubStringBoundedBySIBZ(pcSubStr, pacBounds, pnStartingAt)
			return This.SubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		#>

	   #---------------------------------------------------------------------------#
	  #  FINDING A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS STARTING AT A GIVEN  #
	 #  POSITION, INCLUDING BOUNDS, AND RETURNING THE POSITIONS AS SECTIONS      #
	#===========================================================================#

	def FindSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aSections = This.FindSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nLen = len(aSections)
		nLenBound1 = Q(pcBound1).NumberOfChars()
		nLenBound2 = Q(pcBound2).NumberOfChars()

		aResult = []

		for i = 1 to nLen
			n1 = aSections[i][1] - nLenBound1 + 1
			n2 = aSections[i][2] + nLenBound2
			aResult + [ n1, n2 ]
		next

		return aResult

		#< @FunctionAlternativeForms

		def FindSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindSubStringBetweenSCSIBZZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindSubStringBetweenSCSIBZZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be string or pair of strings.")

			ok

		#--
	
		def FindSubStringBetweenAsSectionsSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindSubStringBoundedByAsSectionsSCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def SubStringBetweenAsSectionsSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBetweenSIBCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def SubStringBoundedByAsSectionsSCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindSubStringBetweenSIBCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindSubStringBetweenAsSectionsSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindSubStringBoundedByAsSectionsSIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#==

		def SubStringBetweenAsSectionsSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def SubStringBoundedByAsSectionsSIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#>

	  #-------------------------------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS SECTIONS BETWEEN TWO GIVEN SUBSTRINGS STARTING AT A GIVEN POSITION AND INCLUDING BOUNDS  #
	#-------------------------------------------------------------------------------------------------------------------------#

	def SubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult
		
		#< @FunctionAlternativeForm

		def SubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.SubStringBetweenSCSIBZZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.SubStringBetweenSCSIBZZ(pcSubStr, pacBouns[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def SubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.SubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def SubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.SubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		#>

	  #======================================================================================================#
	 #  FINDING NTH NEXT OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS  STARTING AT A GIVEN POSITION  #
	#======================================================================================================#

	def FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		nLast = This.NumberOfChars()
		oSection = This.SectionQ(pnStartingAt, nLast)

		cBounded = pcBound1 + pcSubStr + pcBound2
		nLenBounded = Q(cBounded).NumberOfChars()
		nStart = pnStartingAt
		bContinue = TRUE
		nTimes = 0

		while bContinue

			nPos = oSection.FindNextCS(cBounded, nStart, pCaseSensitive)

			if nPos != 0

				nTimes++

				if nTimes = n
					nResult = nPos
					bContinue = FALSE

				else
					nStart = nPos + nLenBounded
				ok

			else
				bContinue = FALSE
			ok
		end

		nResult = ( nPos + pnStartingAt - 1 )

		return nResult

		#< @FunctionAlternativeForms

		def FindNextNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBetweenSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBetweenSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBoundedBySCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBoundedBySCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBoundedByCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBoundedBySCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBoundedByCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBoundedBySCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def NextNthSubStringCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextNthSubStringSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthNextSubStringCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthNextSubStringSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def NextNthSubStringBoundedByCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NextNthSubStringBoundedBySCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NthNextSubStringBoundedByCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NthNextSubStringBoundedBySCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNextNthSubStringBetweenS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthNextSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthNextSubStringBetweenS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthNextSubStringBetweenZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthNextSubStringBetweenSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNextNthSubStringBetweenZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNextNthSubStringBetweenSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def FindNextNthSubStringBoundedByS(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthNextSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthNextSubStringBoundedByS(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNextNthSubStringBoundedByZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNextNthSubStringBoundedBySZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthNextSubStringBoundedByZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthNextSubStringBoundedBySZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		#==

		def NextNthSubString(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextNthSubStringS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthNextSubString(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthNextSubStringS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def NextNthSubStringBoundedBy(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def NextNthSubStringBoundedByS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def NthNextSubStringBoundedBy(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def NthNextSubStringBoundedByS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #----------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS NEXT NTH OCCURRENCE BETWEEN TWO GIVEN SUBSTRINGS  #
	#----------------------------------------------------------------------------------#

	def NextNthSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNextNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForms

		def NthNextSubStringBetweenSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NextNthSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextNthSubStringBoundedBySCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.NextNthSubStringBetweenCSZ(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NextNthSubStringBetweenCSZ(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		def NthNextSubStringBoundedBySCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NextNthSubStringBoundedBySCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def NextNthSubStringBetweenZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NextNthSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def NthNextSubStringBetweenSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NextNthSubStringBetweenZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextNthSubStringBoundedBySZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.NextNthSubStringBoundedBySCSZ(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def NthNextSubStringBoundedBySZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NextNthSubStringBoundedBySZ(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #--------------------------------------------------------------------------------------------------#
	 #  FINDING NEXT OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#==================================================================================================#

	def FindNextSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		return This.FindNthSubStringBetweenCS(1, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#< @FunctionAlternativeForms

		def FindNextSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def FindNextSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(1, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBoundedByCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCS(1, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#--

		def NextSubStringCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextSubStringBoundedByCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NextSubStringSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextSubStringBoundedBySCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNextSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindNextSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNextSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNextSubStringBetweenZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNextSubStringBetweenSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def FindNextSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(1, pcSubStr, pacBounds, pnStartingAt)

		def FindNextSubStringBoundedByZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)

		def FindNextSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedBy(1, pcSubStr, pacBounds, pnStartingAt)

		def FindNextSubStringBoundedBySZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)

		#--

		def NextSubString(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextSubStringBoundedBy(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)

		def NextSubStringS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextSubStringBoundedByS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)

		#>

	  #-----------------------------------------------------------------------------------------------------#
	 #  GETTING SUBSTRING AND ITS NEXT NTH OCCURRENCE BETWEEN TWO SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#-----------------------------------------------------------------------------------------------------#

	def NextSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNextSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForms

		def NextSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NextSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextSubStringBoundedByCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.NextSubStringBetweenCSZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NextSubStringBetweenCSZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		def NextSubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.NextSubStringBoundedByCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def NextSubStringBetweenZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NextNthSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def NextSubStringBetweenSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NextSubStringBetweenZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextSubStringBoundedBySZ(pcSubStr, pacBounds, pnStartingAt)
			return This.NextSubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		#>

	  #=========================================================================================================#
	 #  FINDING NTH PREVIOUS OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#=========================================================================================================#

	def FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		nLast = This.NumberOfChars()
		oSection = This.SectionQ(pnStartingAt, nLast).FindSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		cBounded = pcBound1 + pcSubStr + pcBound2
		nLenBounded = Q(cBounded).NumberOfChars()
		nStart = pnStartingAt
		bContinue = TRUE
		nTimes = 0

		while bContinue

			nPos = oSection.FindPreviousCS(cBounded, nStart, pCaseSensitive)

			if nPos != 0

				nTimes++

				if nTimes = n
					nResult = nPos
					bContinue = FALSE

				else
					nStart = nPos - 1
				ok

			else
				bContinue = FALSE
			ok
		end

		nResult = ( nPos + pnStartingAt - 1 )

		return nResult

		#< @FunctionAlternativeForms

		def FindNthPreviousSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthPreviousSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindPreviousNthSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

			return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthPreviousSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindPreviousNthSubStringBoundedByCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthPreviousSubStringBoundedByCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def PreviousNthSubStringSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthPreviousSubStringSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def PreviousNthSubStringSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthPreviousSubStringSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def PreviousNthSubStringBoundedBySCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NthPreviousSubStringBoundedBySCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def PreviousNthSubStringBoundedBySCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NthPreviousSubStringBoundedBySCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindPreviousNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthPreviousSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindPreviousNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthPreviousSubStringBetweenZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindPreviousNthSubStringBetweenZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def FindPreviousNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindPreviousNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def FindNthPreviousSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def FindPreviousNthSubStringBoundedByZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthPreviousSubStringBoundedByZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		#==

		def PreviousNthSubStringS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthPreviousSubStringS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def PreviousNthSubStringSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthPreviousSubStringSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def PreviousNthSubStringBoundedByS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def NthPreviousSubStringBoundedByS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def PreviousNthSubStringBoundedBySZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		def NthPreviousSubStringBoundedBySZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedBy(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #------------------------------------------------------------------------------------------------------#
	 #  FINDING PREVIOUS OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS  STARTING AT A GIVEN POSITION  #
	#======================================================================================================#

	def FindPreviousSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		return This.FindNthSubStringBetweenCS(1, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#< @FunctionAlternativeForms

		def FindPreviousSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def FindPreviousSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCS(1, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindPreviousSubStringBoundedByCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def PreviousSubStringSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def PreviousSubStringSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def PreviousSubStringBoundedBySCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def PreviousSubStringBoundedBySCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindPreviousSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindPreviousSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindPreviousSubStringBetweenZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def FindPreviousSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)
			return This.FindPreviousSubStringBoundedByCS(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def FindPreviousSubStringBoundedByZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)

		#==

		def PreviousSubStringS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def PreviousSubStringSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetween(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def PreviousSubStringBoundedByS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)

		def PreviousSubStringBoundedBySZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedBy(pcSubStr, pacBounds, pnStartingAt)

		#>

	  #==========================================================================================================================#
	 #  FINDING NTH NEXT OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS STARTING AT A GIVEN POSITION AND INCLUDING BOuNDS  #
	#==========================================================================================================================#

	def FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		nPos = This.FindNextNthSubStringCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nResult = nPos + Q(pcBound1).NumberOfChars() - 1

		return nResult

		#< @FunctionAlternativeForms

		def FindNextNthSubStringBetweenSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBetweenSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBetweenSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBetweenSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBoundedBySCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBoundedBySCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBoundedByCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextNthSubStringBoundedBySCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBoundedByCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthNextSubStringBoundedBySCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def NextNthSubStringCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextNthSubStringSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthNextSubStringCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthNextSubStringSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def NextNthSubStringBoundedByCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NextNthSubStringBoundedBySCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NthNextSubStringBoundedByCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NthNextSubStringBoundedBySCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNextNthSubStringBetweenSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthNextSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthNextSubStringBetweenSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthNextSubStringBetweenIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthNextSubStringBetweenSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNextNthSubStringBetweenIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNextNthSubStringBetweenSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def FindNextNthSubStringBoundedBySIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthNextSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthNextSubStringBoundedBySIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNextNthSubStringBoundedByZIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNextNthSubStringBoundedBySIBZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthNextSubStringBoundedByZIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthNextSubStringBoundedBySIBZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		#==

		def NextNthSubStringIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextNthSubStringSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthNextSubStringIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthNextSubStringSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def NextNthSubStringBoundedByIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def NextNthSubStringBoundedBySIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def NthNextSubStringBoundedByIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def NthNextSubStringBoundedBySIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #----------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS NEXT NTH OCCURRENCE BETWEEN TWO GIVEN SUBSTRINGS  #
	#----------------------------------------------------------------------------------#

	def NextNthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForms

		def NthNextSubStringBetweenSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NextNthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextNthSubStringBoundedBySCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.NextNthSubStringBetweenCSIBZ(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NextNthSubStringBetweenCSIBZ(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		def NthNextSubStringBoundedBySCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NextNthSubStringBoundedBySCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def NextNthSubStringBetweenIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NextNthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def NthNextSubStringBetweenSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NextNthSubStringBetweenIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextNthSubStringBoundedBySIBZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.NextNthSubStringBoundedBySCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def NthNextSubStringBoundedBySIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NextNthSubStringBoundedBySIBZ(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #--------------------------------------------------------------------------------------------------#
	 #  FINDING NEXT OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#==================================================================================================#

	def FindNextSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		return This.FindNthSubStringBetweenCSIB(1, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#< @FunctionAlternativeForms

		def FindNextSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def FindNextSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(1, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextNthSubStringBoundedByCSIB(1, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNextSubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#--

		def NextSubStringCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextSubStringBoundedByCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NextSubStringSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextSubStringBoundedBySCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNextSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNextSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindNextSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNextSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNextSubStringBetweenIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNextSubStringBetweenSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def FindNextSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(1, pcSubStr, pacBounds, pnStartingAt)

		def FindNextSubStringBoundedByZIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)

		def FindNextSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextNthSubStringBoundedByIB(1, pcSubStr, pacBounds, pnStartingAt)

		def FindNextSubStringBoundedBySIBZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindNextSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)

		#--

		def NextSubStringIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextSubStringBoundedByIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)

		def NextSubStringSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextSubStringBoundedBySIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNextSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)

		#>

	  #-----------------------------------------------------------------------------------------------------#
	 #  GETTING SUBSTRING AND ITS NEXT NTH OCCURRENCE BETWEEN TWO SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#-----------------------------------------------------------------------------------------------------#

	def NextSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNextSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForms

		def NextSubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.NextSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NextSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.NextSubStringBetweenCSIBZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NextSubStringBetweenCSIBZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		def NextSubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.NextSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def NextSubStringBetweenIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NextNthSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def NextSubStringBetweenSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.NextSubStringBetweenIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NextSubStringBoundedBySIBZ(pcSubStr, pacBounds, pnStartingAt)
			return This.NextSubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		#>

	  #=========================================================================================================#
	 #  FINDING NTH PREVIOUS OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#=========================================================================================================#

	def FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		nPos = This.FindPreviousNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nResult = nPos + Q(pcBound1).NumberOfChars()

		return nResult

		#< @FunctionAlternativeForms

		def FindNthPreviousSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthPreviousSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindPreviousNthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

			return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthPreviousSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindPreviousNthSubStringBoundedByCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindNthPreviousSubStringBoundedByCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def PreviousNthSubStringSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthPreviousSubStringSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def PreviousNthSubStringSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthPreviousSubStringSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def PreviousNthSubStringBoundedBySCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NthPreviousSubStringBoundedBySCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def PreviousNthSubStringBoundedBySCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def NthPreviousSubStringBoundedBySCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindPreviousNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindPreviousNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthPreviousSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindPreviousNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthPreviousSubStringBetweenIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindPreviousNthSubStringBetweenIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def FindPreviousNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindPreviousNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def FindNthPreviousSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def FindPreviousNthSubStringBoundedByZIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def FindNthPreviousSubStringBoundedByZIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		#==

		def PreviousNthSubStringSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthPreviousSubStringSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def PreviousNthSubStringSZIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthPreviousSubStringSZIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def PreviousNthSubStringBoundedBySIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def NthPreviousSubStringBoundedBySIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def PreviousNthSubStringBoundedBySIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		def NthPreviousSubStringBoundedBySIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByIB(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #------------------------------------------------------------------------------------------------------#
	 #  FINDING PREVIOUS OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS  STARTING AT A GIVEN POSITION  #
	#======================================================================================================#

	def FindPreviousSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		return This.FindNthSubStringBetweenCSIB(1, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#< @FunctionAlternativeForms

		def FindPreviousSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def FindPreviousSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousNthSubStringBoundedByCSIB(1, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FindPreviousSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def PreviousSubStringSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def PreviousSubStringSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		#--

		def PreviousSubStringBoundedBySCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def PreviousSubStringBoundedBySCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindPreviousSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindPreviousSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindPreviousSubStringBetweenIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def FindPreviousSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindPreviousSubStringBoundedByCSIB(pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

		def FindPreviousSubStringBoundedByZIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)

		#==

		def PreviousSubStringSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def PreviousSubStringSZIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBetweenIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		#--

		def PreviousSubStringBoundedBySIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)

		def PreviousSubStringBoundedBySIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindPreviousSubStringBoundedByIB(pcSubStr, pacBounds, pnStartingAt)

		#>

	  #===================================================================#
	 #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS  #
	#===================================================================#

	def FindNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nResult = this.FindNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, 1, pCaseSensitive)
		return nResult

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenCS(n, pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return TThis.FindNthSubStringBetweenCS(n, pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindNthSubStringBoundedByCSZ(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCS(n, pcSubStr, pacBound, pCaseSensitives)

		#==

		def NthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def NthSubStringBoundedByCS(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCS(n, pcSubStr, pacBounds, pCaseSensitive)
	
		#>

	#-- WITHOUT CASESENSITIVE

	def FindNthSubStringSubStringBetween(n, pcSubStr, pcBound1, pcBound2)
		return This.FindNthSubStringSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound1, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBy(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByCS(n, pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#--
	
		def FindNthSubStringBetweenZ(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2)

		def FindNthSubStringBoundedByZ(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedBy(n, pcSubStr, pacBounds)

		#==

		def NthSubStringBetween(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetween(n, pcSubStr, pcBound1, pcBound2)

		def NthSubStringBoundedBy(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedBy(n, pcSubStr, pacBounds)

		#>

	  #----------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING WITH THE POSITION OF ITS NTH OCCURRENCE BETWEEN TWO GIVEN SUBSTRINGS  #
	#----------------------------------------------------------------------------------------------#

	def NthSubStringBetweenCSZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def NthSubStringBoundedByCSZ(n, pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.NthSubStringBetweenCSZ(n, pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NthSubStringBetweenCSZ(n, pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)
			else
				StzRaise("Incorrect param type! pacBounds must ba a string or pair of strings.")

			ok

		#>
				
	  #---------------------------------------------------------------------#
	 #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS  #
	#=====================================================================#

	def FindFirstSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		return This.FindNthSubStringBetweenCS(1, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCS(1, pcSubStr, pacBounds, pCaseSensitive)

		#--
	
		def FindFirstSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindFirstSubStringBoundedByCSZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCS(pcSubStr, pacBound, pCaseSensitives)

		#==

		def FirstSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FirstSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
	
		#>

	#-- WITHOUT CASESENSITIVE

	def FindFirstSubStringSubStringBetween(pcSubStr, pcBound1, pcBound2)
		return This.FindFirstSubStringSubStringBetweenCS(pcSubStr, pcBound1, pcBound1, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBy(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByCS(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#--
	
		def FindFirstSubStringBetweenZ(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetween(pcSubStr, pcBound1, pcBound2)

		def FindFirstSubStringBoundedByZ(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedBy(pcSubStr, pacBounds)

		#==

		def FirstSubStringBetween(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetween(pcSubStr, pcBound1, pcBound2)

		def FirstSubStringBoundedBy(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedBy(pcSubStr, pacBounds)
	
		#>

	  #------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING WITH THE POSITION OF ITS FIRST OCCURRENCE BETWEEN TWO GIVEN SUBSTRINGS  #
	#------------------------------------------------------------------------------------------------#

	def FirstSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.FindFirstSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def FirstSubStringBoundedByCSZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FirstSubStringBetweenCSZ(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FirstSubStringBetweenCSZ(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)
			else
				StzRaise("Incorrect param type! pacBounds must ba a string or pair of strings.")

			ok

		#>

	  #--------------------------------------------------------------------#
	 #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO SUBSTRINGS  #
	#====================================================================#

	def FindLastSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive) # TODO: check performance!
		nLast = This.NumberOfOccurrenceOfSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		return This.FindNthSubStringBetweenCS(nLast, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenCS(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return TThis.FindLastSubStringBetweenCS(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindLastSubStringBoundedByCSZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCS(pcSubStr, pacBound, pCaseSensitives)

		#==

		def LastSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def LastSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCS(pcSubStr, pacBounds, pCaseSensitive)
	
		#>

	#-- WITHOUT CASESENSITIVE

	def FindLastSubStringSubStringBetween(pcSubStr, pcBound1, pcBound2)
		return This.FindLastSubStringSubStringBetweenCS(pcSubStr, pcBound1, pcBound1, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBy(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByCS(pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#--
	
		def FindLastSubStringBetweenZ(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetween(pcSubStr, pcBound1, pcBound2)

		def FindLastSubStringBoundedByZ(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedBy(pcSubStr, pacBounds)

		#==

		def LastSubStringBetween(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetween(pcSubStr, pcBound1, pcBound2)

		def LastSubStringBoundedBy(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedBy(pcSubStr, pacBounds)
	
		#>

	  #------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING WITH THE POSITION OF ITS LAST OCCURRENCE BETWEEN TWO GIVEN SUBSTRINGS  #
	#------------------------------------------------------------------------------------------------#

	def LastSubStringBetweenCSZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.FindLastSubStringBetweenCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def LastSubStringBoundedByCSZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.LastSubStringBetweenCSZ(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.LastSubStringBetweenCSZ(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)
			else
				StzRaise("Incorrect param type! pacBounds must ba a string or pair of strings.")

			ok

		#>

	   #-------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY     #
	 #  TWO OTHER SUBSTRINGS AND RETURNING THEM AS SECTIONS  #
	#=======================================================#

	def FindNthSubStringBetweenCSZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nPos = This.FindNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nLenBound1 = Q(pcBound1).NumberOfChars()

		aResult = [ nPos, nPos + nLenBound1 - 1 ]

		return aResult

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByCSZZ(n, pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenCSZZ(n, pcSubStr, pcBounds, pcBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenCSZZ(n, pcSubStr, pcBounds[1], pcBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenAsSectionsCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindNthSubStringBetweenCSZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindNthSubStringBoundedByAsSectionsCS(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCSZZ(n, pcSubStr, pacBounds, pCaseSensitive)

		#==

		def NthSubStringBetweenAsSectionsCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindNthSubStringBetweenCSZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def NthSubStringBoundedByAsSectionsCS(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCSZZ(n, pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenZZ(n, pcSubStr, pcBound1, pcBound2)
		return This.FindNthSubStringBetweenCSZZ(n, pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByZZ(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByZZ(n, pcSubStr, pacBounds)

		#--
	
		def FindNthSubStringBetweenAsSections(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetweenZZ(n, pcSubStr, pcBound1, pcBound2)

		def FindNthSubStringBoundedByAsSections(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByZZ(n, pcSubStr, pacBounds)

		#==

		def NthSubStringBetweenAsSections(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetweenZZ(n, pcSubStr, pcBound1, pcBound2)

		def NthSubStringBoundedByAsSections(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByZZ(n, pcSubStr, pacBounds)

		#>

	  #-----------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS NTH OCCURRENCE AS SECTION  #
	#-----------------------------------------------------------#

	def NthSubStringBetweenCSZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.NthSubStringBetweenCSZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def NthSubStringBoundedByCSZZ(n, pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.NthSubStringBetweenCSZZ(n, pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds)
				return This.NthSubStringBetweenCSZZ(n, pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def NthSubStringBetweenZZ(n, pcSubStr, pcBound1, pcBound2)
		return This.NthSubStringBetweenCSZZ(n, pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def NthSubStringBoundedByZZ(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.NthSubStringBoundedByCSZZ(n, pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#>

	  #------------------------------------------------------------------------------------------#
	 #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS INCLUDING BOUNDS  #
	#==========================================================================================#

	def FindNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nResult = This.FindNextNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, 1, pCaseSensitive)
		return nResult

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenCSIB(n, pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return TThis.FindNthSubStringBetweenCSIB(n, pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindNthSubStringBoundedByCSIBZ(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCSIB(n, pcSubStr, pacBound, pCaseSensitives)

		#==

		def NthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def NthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCSIB(n, pcSubStr, pacBounds, pCaseSensitive)
	
		#>

	#-- WITHOUT CASESENSITIVE

	def FindNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2)
		return This.FindNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByIB(n, pcSubStr, pacBounds)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenIB(n, pcSubStr, pacBounds, pacBounds)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return TThis.FindNthSubStringBetweenIB(n, pcSubStr, pacBounds[1], pacBounds[2])

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenZIB(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2)

		def FindNthSubStringBoundedByZIB(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByIB(n, pcSubStr, pacBounds)

		#==

		def NthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetweenIB(n, pcSubStr, pcBound1, pcBound2)

		def NthSubStringBoundedByIB(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByIB(n, pcSubStr, pacBounds)

		#>

	  #----------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS NTH OCCURRENCE BETWEEN TWO GIVEN SUBSTRINGS INCLUDING BOUNDS  #
	#----------------------------------------------------------------------------------------------#

	def NthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		aResult = [ pcSubStr, This.NthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		#< @FunctionAlternativeForm

		def NthSubStringBoundedByCSIBZ(n, pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.NthSubStringBetweenCSIBZ(n, pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NthSubStringBetweenCSIBZ(n, pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#>

	#-- WITHOUT CASESENSITIVITY

	def NthSubStringBetweenIBZ(n, pcSubStr, pcBound1, pcBound2)
		return This.NthSubStringBetweenCSIBZ(n, pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def NthSubStringBoundedByIBZ(n, pcSubStr, pacBounds)
			return This.NthSubStringBoundedByCSIBZ(n, pcSubStr, pacBounds, :CaseSensitive = TRUE)

		#>

	   #-------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER             #
	 #  SUBSTRINGS INCLUDING BOUNDS AND RETURNING THEIR POSITIONS AS SECTIONS  #
	#=========================================================================#

	def FindNthSubStringBetweenCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nPos = This.FindNthSubStringBetweenCSIB(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nLenBound1 = Q(pcBound1).NumberOfChars()

		aResult = [ pcSubStr, (nPos + nLenBound1 - 1) ]

		return aResult

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByCSIBZZ(n, pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenCSIBZZ(n, pcSubStr, pcBounds, pcBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenCSIBZZ(n, pcSubStr, pcBounds[1], pcBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenAsSectionsCSIB(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindNthSubStringBetweenCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindNthSubStringBoundedByAsSectionsCSIB(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCSIBZZ(n, pcSubStr, pacBounds, pCaseSensitive)

		#==

		def NthSubStringBetweenAsSectionsCSIB(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindNthSubStringBetweenCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def NthSubStringBoundedByAsSectionsCSIB(n, pcSubStr, pacBounds, pCaseSensitive)
			return This.FindNthSubStringBoundedByCSIBZZ(n, pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenZZIB(n, pcSubStr, pcBound1, pcBound2)
		return This.FindNthSubStringBetweenCSIBZZ(n, pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBetweenIBZZ(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetweenIBZZ(n, pcSubStr, pcBound1, pcBound2)

		def FindNthSubStringBoundedByIBZZ(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByIBZZ(n, pcSubStr, pacBounds)

		#--
	
		def FindNthSubStringBetweenAsSectionsIB(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetweenIBZZ(n, pcSubStr, pcBound1, pcBound2)

		def FindNthSubStringBoundedByAsSectionsIB(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByIBZZ(n, pcSubStr, pacBounds)

		#==

		def NthSubStringBetweenAsSectionsIB(n, pcSubStr, pcBound1, pcBound2)
			return This.FindNthSubStringBetweenIBZZ(n, pcSubStr, pcBound1, pcBound2)

		def NthSubStringBoundedByAsSectionsIB(n, pcSubStr, pacBounds)
			return This.FindNthSubStringBoundedByIBZZ(n, pcSubStr, pacBounds)

		#>
		
	  #----------------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSSTRING AND ITS NTH OCCURRENCE AS SECTION BETWEEN TWO GIVEN SUBSTRINGS INCLUDING BOUNDS  #
	#----------------------------------------------------------------------------------------------------------#

	def NthSubStringBetweenCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNthSubStringBetweenCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive) ]
		return aResult

		def NthSubStringBoundedByCSIBZZ(n, pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.NthSubStringBetweenCSIBZZ(n, pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NthSubStringBetweenCSIBZZ(n, pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

	   #-----------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY   #
	 #  TWO OTHER SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#=====================================================#

	def FindNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		if isList(pnStaringAt) and Q(pnStaringAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		nLast = This.NumberOfChars()
		nPos = This.SectionQ(pnStartingAt, nLast).FindNthSubStringBetweenCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		nResult = nPos + pnStartingAt

		return nResult

		#< @FunctionalternativeForms

		def FindNthSubStringBoundedBySCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenSCS(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenSCS(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthSubStringBoundedBySCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBoundedBySCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def NthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthSubStringBoundedBySCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBoundedBySCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByS(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedByS(n, pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindNthSubStringBetweenSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNthSubStringBetweenS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthSubStringBoundedBySZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedByS(n, pcSubStr, pacBounds, pnStartingAt)

		#==

		def NthSubStringBetweenS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindBetweenS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthSubStringBoundedByS(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedByS(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #----------------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS NTH OCCURRENCE BETWEEN TWO GIVEN SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#----------------------------------------------------------------------------------------------------------#

	def NthSubStringBetweenSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNthSubStringBetweenSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive) ]
		return aResult

		def NthSubStringBoundedBySCSZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.NthSubStringBetweenSCSZ(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NthSubStringBetweenSCSZ(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

	#-- WITHOUT CASESENSITIVITY

	def NthSubStringBetweenSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NthSubStringBetweenSCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		def NthSubStringBoundedBySZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.NthSubStringBoundedBySCSZ(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

	   #-------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  STARTING AT A GIVEN POSITION AND RETURNING POSITIONS AS SECTIONS       #
	#=========================================================================#

	def FindNthSubStringBetweenSCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nPos = This.FindNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nLenSubStr = Q(pcSubStr).NumberOfChars()

		aResult = [ pcSubStr, (nPos + nLenSubStr - 1) ]
		return aResult

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenSCSZZ(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).isPairOfStrings()
				return This.FindNthSubStringBetweenSCSZZ(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenAsSectionsSCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBetweenSCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthSubStringBoundedByAsSectionsSCS(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBoundedBySCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def NthSubStringBetweenSCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBetweenSCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthSubStringBoundedBySCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBoundedBySCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#--

	def FindNthSubStringBetweenSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindNthSubStringBetweenSCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySZZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedBySZZ(n, pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindNthSubStringBetweenAsSectionsS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNthSubStringBetweenSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthSubStringBoundedByAsSectionsS(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedBySZZ(n, pcSubStr, pacBounds, pnStartingAt)

		#==

		def NthSubStringBetweenSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNthSubStringBetweenSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthSubStringBoundedBySZZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedBySZZ(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #----------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS NTH OCCURRENCE AS SECTION BETWEEN TWO GIVEN SUBSTRINGS  #
	#----------------------------------------------------------------------------------------#

	def NthSubStringBetweenAsSectionsSCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNthSubStringBetweenAsSectionsSCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive) ]
		return aResult

		def NthSubStringBoundedByAsSectionsSCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.NthSubStringBetweenAsSectionsSCSZZ(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NthSubStringBetweenAsSectionsSCSZZ(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

	#-- WITHOUT CASESENSITIVITY

	def NthSubStringBetweenAsSectionsSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NthSubStringBetweenAsSectionsSCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		def NthSubStringBoundedByAsSectionsSZZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.NthSubStringBoundedByAsSectionsSCSZZ(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

	   #---------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER   #
	 #  SUBSTRINGSSTARTING AT A GIVEN POSITION AND INCLUDING BOUNDS  #
	#===============================================================#

	def FindNthSubStringBetweenSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nPos = This.FindNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pnStaringAt, pCaseSensitive)
		nLenBound1 = Q(pcBound1).NumberOfChars()
		nResult = nPos - nLenBound1
		return nResult

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenSCSIB(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenSCSIB(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBetweenSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthSubStringBoundedBySCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBoundedBySCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def NthSubStringBetweenSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBetweenSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthSubStringBoundedBySCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBoundedBySCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindNthSubStringBetweenSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedBySIB(n, pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindNthSubStringBetweenSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNthSubStringBetweenSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthSubStringBoundedBySIBZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedBySIB(n, pcSubStr, pacBounds, pnStartingAt)

		#==

		def NthSubStringBetweenSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNthSubStringBetweenSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthSubStringBoundedBySIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindBoundedBySIB(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #---------------------------------------------------------------------------------------------------------#
	 #  GETTING THE SUBSTRING AND ITS NTH OCCURRENCE AS SECTION BETWEEN TOW GIVEN SUBSTRINGS INCLUDING BOUNDS  #
	#---------------------------------------------------------------------------------------------------------#

	def NthSubStringBetweenSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNthSubStringBetweenSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive) ]
		return aResult

		def NthSubStringBoundedBySCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.NthSubStringBetweenSCSIBZ(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.thSubStringBetweenSCSIBZ(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of string.")
			ok

	#-- WITHOUT CASESENSITIVITY

	def NthSubStringBetweenSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NthSubStringBetweenSCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		def NthSubStringBoundedBySIBZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.NthSubStringBoundedBySCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive) = TRUE

	   #-----------------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS STARTING   #
	 #  AT A GIVEN POSITION, INCLUDING BOUNDS, AND RETURNING THE POSITIONS AS SECTIONS   #
	#===================================================================================#

	def FindNthSubStringBetweenSCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		nPos = This.FindNthSubStringBetweenSCS(n, pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		nLenSubStr = Q(pcSubStr).NumberOfChars()
		nLenBound1 = Q(pcBound1).NumberOfChars()
		nLenBound2 = Q(pcBound2).NumberOfChars()
		
		n1 = nPos - nLenBound1 + 1
		n2 = nPos + nLenBound2

		aResult = [ pcSubStr, [n1, n2] ]

		return aResult

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenSCSIBZZ(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenSCSIBZZ(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be string or pair of strings.")

			ok

		#--
	
		def FindNthSubStringBetweenAsSectionsSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBetweenSCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindNthSubStringBoundedByAsSectionsSCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBoundedBySCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def NthSubStringBetweenAsSectionsSCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBetweenSIBCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthSubStringBoundedByAsSectionsSCSIB(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindNthSubStringBoundedBySCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindNthSubStringBetweenSIBCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySIBZZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedBySIBZZ(n, pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindNthSubStringBetweenAsSectionsSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNthSubStringBetweenSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindNthSubStringBoundedByAsSectionsSIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedBySIBZZ(n, pcSubStr, pacBounds, pnStartingAt)

		#==

		def NthSubStringBetweenAsSectionsSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindNthSubStringBetweenSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def NthSubStringBoundedByAsSectionsSIB(n, pcSubStr, pacBounds, pnStartingAt)
			return This.FindNthSubStringBoundedBySIBZZ(n, pcSubStr, pacBounds, pnStartingAt)

		#>

	  #----------------------------------------------------------------------------------------------------------------------------------#
	 #  THE SUBSTRING AND ITS NTH OCCURRENCE AS SECTION BETWEEN TWO GIVEN SUBSTRINGS STARTING AT A GIVEN POSITION ABD INCLUDING BOUNDS  #
	#----------------------------------------------------------------------------------------------------------------------------------#

	def NthSubStringBetweenSCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		aResult = [ pcSubStr, This.FindNthSubStringBetweenSCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive) ]
		return aResult

		def NthSubStringBoundedBySCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This. NthSubStringBetweenSCSIBZZ(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.NthSubStringBetweenSCSIBZZ(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

	#-- WITHOUT CASESENSITIVITY

	def NthSubStringBetweenSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.NthSubStringBetweenSCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def NthSubStringBoundedBySIBZZ(n, pcSubStr, pacBounds, pnStartingAt)
			return This.NthSubStringBoundedBySCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, :CaseSensitive = TRUE)

	   #----------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY  #
	 #  TWO OTHER SUBSTRINGS GOING IN A GIVEN DIRECTION   #
ici	#====================================================#

	def FindNthSubStringBetweenDCS(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByDCS(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenDCS(n, pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenDCS(n, pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenDCSZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCS(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindNthSubStringBoundedByDCSZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCS(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def NthSubStringBetweenDCS(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCS(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByDCS(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCS(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def NthSubStringBetweenDCSZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCS(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByDCSZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCS(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenD(n, pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindNthSubStringBetweenDCS(n, pcSubStr, pcBound1, pcBound2, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByD(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByD(n, pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindNthSubStringBetweenDZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenD(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindNthSubStringBoundedByDZ(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByD(n, pcSubStr, pacBounds, pcDirection)

		#==

		def NthSubStringBetweenD(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenD(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def NthSubStringBoundedByD(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByD(n, pcSubStr, pacBounds, pcDirection)

		def NthSubStringBetweenDZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenD(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def NthSubStringBoundedByDZ(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByD(n, pcSubStr, pacBounds, pcDirection)

		#>

	   #-------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  GOING INA GIVEN DIRECTION AND RETURNING POSITIONS AS SECTIONS          #
	#-------------------------------------------------------------------------#

	def FindNthSubStringBetweenDCSZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByDCSZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenDCSZZ(n, pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfNumbers()
				return This.FindNthSubStringBetweenDCSZZ(n, pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindNthSubStringBetweenAsSectionsDCS(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCSZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindNthSubStringBoundedByAsSectionsDCS(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCSZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def NthSubStringBetweenDCSZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCSZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByDCSZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCSZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def NthSubStringBetweenAsSectionsDCS(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCSZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByAsSectionsDCS(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCSZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenDZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindNthSubStringBetweenDZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByDZZ(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDZZ(n, pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindNthSubStringBetweenAsSectionsD(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindNthSubStringBoundedByAsSectionsD(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDZZ(n, pcSubStr, pacBounds, pcDirection)

		#==

		def NthSubStringBetweenDZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def NthSubStringBoundedByDZZ(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDZZ(n, pcSubStr, pacBounds, pcDirection)

		def NthSubStringBetweenAsSectionsD(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def NthSubStringBoundedByAsSectionsD(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDZZ(n, pcSubStr, pacBounds, pcDirection)

		#>

	   #--------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER  #
	 #  SUBSTRINGS GOING IN A GIVEN DIRECTION AND INCLUDING BOUNDS  #
	#--------------------------------------------------------------#

	def FindNthSubStringBetweenDCSIB(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByDCSIB(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenDCSIB(n, pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenDCSIB(n, pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindNthSubStringBetweenDCSIBZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCSIB(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindNthSubStringBoundedByDCSIBZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCSIB(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def NthSubStringBetweenDCSIB(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCSIB(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByDCSIB(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCSIB(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def NthSubStringBetweenDCSIBZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCSIB(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByDCSIBZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCSIB(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenDIB(n, pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindNthSubStringBetweenDCSIB(n, pcSubStr, pcBound1, pcBound2, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByDIB(n, pcSubStr, pacBounds, pcDirection)
			return This.FindBoundedByDIB(n, pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindNthSubStringBetweenDIBZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDIB(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindNthSubStringBoundedByDIBZ(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDIB(n, pcSubStr, pacBounds, pcDirection)

		#==

		def NthSubStringBetweenDIB(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDIB(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def NthSubStringBoundedByDIB(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDIB(n, pcSubStr, pacBounds, pcDirection)

		def NthSubStringBetweenDIBZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDIB(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def NthSubStringBoundedByDIBZ(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDIB(n, pcSubStr, pacBounds, pcDirection)

		#>

	   #-------------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS GOING  #
	 #  IN A GIVENDIRECTION, INCLUDING BOUNDS, AND RETURNING POSITIONS AS SECTIONS   # 
	#-------------------------------------------------------------------------------#

	def FindNthSubStringBetweenDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByDCSIBZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenDCSIBZZ(n, pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfNumbers()
				return This.FindNthSubStringBetweenDCSIBZZ(n, pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindNthSubStringBetweenAsSectionsDCSIB(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindNthSubStringBoundedByAsSectionsDCSIB(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindBoundedByDCSIBZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def NthSubStringBetweenDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByDCSIBZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCSIBZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def NthSubStringBetweenAsSectionsDCSIB(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenDCIBSZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByAsSectionsDCSIB(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedByDCSIBZZ(n, pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenDIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindNthSubStringBetweenDIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedByDIBZZ(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDIBZZ(n, pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindNthSubStringBetweenAsSectionsDIB(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindNthSubStringBoundedByAsSectionsDIB(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDIBZZ(n, pcSubStr, pacBounds, pcDirection)

		#==

		def NthSubStringBetweenDIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def NthSubStringBoundedByDIBZZ(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDIBZZ(n, pcSubStr, pacBounds, pcDirection)

		def NthSubStringBetweenAsSectionsDIB(n, pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindNthSubStringBetweenDIBZZ(n, pcSubStr, pcBound1, pcBound2, pcDirection)

		def NthSubStringBoundedByAsSectionsDIB(n, pcSubStr, pacBounds, pcDirection)
			return This.FindNthSubStringBoundedByDIBZZ(n, pcSubStr, pacBounds, pcDirection)

		#>

	   #-------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  STARTING AT A GIVEN POSITION AND GOING IN A GIVEN DIRECTION            #
	#-------------------------------------------------------------------------#

	def FindNthSubStringBetweenSDCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySDCS(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenSDCS(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

			but isLsit(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenSDCS(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindNthSubStringBetweenSDCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindNthSubStringBoundedBySDCSZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCS(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def NthSubStringBetweenSDCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSD(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedBySDCS(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCS(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def NthSubStringBetweenSDCSZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def NthSubStringBoundedBySDCSZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCS(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenSD(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindNthSubStringBetweenSDCS(n, pcSubStr, pcBound1, pcBound2,pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySD(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySD(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindNthSubStringBetweenSDZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSD(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindNthSubStringBoundedBySDZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySD(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def NthSubStringBetweenSD(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSD(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedBySD(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySD(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def NthSubStringBetweenSDZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSD(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedBySDZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySD(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #----------------------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING       #
	 #  AT A GIVEN POSITION, GOING IN A GIVEN DIRECTION, AND RETURNING POSITIONS AS SECTIONS  #
	#----------------------------------------------------------------------------------------#

	def FindNthSubStringBetweenSDCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySDCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindBoundedBySDCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#--
	
		def FindNthSubStringBetweenAsSectionsSDCS(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindNthSubStringBoundedByAsSectionsSDCS(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def NthSubStringBoundedBySDCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByAsSectionsSDCS(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenSDZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindNthSubStringBetweenSDCSZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySDZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindBoundedBySDZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindNthSubStringBetweenAsSectionsSD(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindNthSubStringBoundedByAsSectionsSD(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def NthSubStringBetweenSDZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedBySDZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def NthSubStringBetweenAsSectionsSD(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedByAsSectionsSD(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #-----------------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING  #
	 #  AT A GIVEN POSITION, GOING IN A GIVEN DIRECTION, AND INCLUDING BOUNDS            #
	#-----------------------------------------------------------------------------------#

	def FindNthSubStringBetweenSDCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySDCSIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindNthSubStringBetweenSDCSIB(n, pcSubStr, pacBounds, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

			but isLsit(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindNthSubStringBetweenSDCSIB(n, pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindNthSubStringBetweenSDCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindNthSubStringBoundedBySDCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def NthSubStringBetweenSDCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedBySDCSIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindBoundedBySDCSIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def NthSubStringBetweenSDCSIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def NthSubStringBoundedBySDCSIBZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenSDIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindNthSubStringBetweenSDCSIB(n, pcSubStr, pcBound1, pcBound2,pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySDIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindNthSubStringBetweenSDIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindNthSubStringBoundedBySDIBZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def NthSubStringBetweenSDIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedBySDIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def NthSubStringBetweenSDIBZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedBySDIBZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #-----------------------------------------------------------------------------------------------#
	  #  FINDING NTH OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING AT A GIVEN   #
	 #  POSITION, GOING IN A GIVEN DIRECTION, INCLUDING BOUNDS, AND RETURNING POSITIONS AS SECTIONS  #
	#-----------------------------------------------------------------------------------------------#

	def FindNthSubStringBetweenSDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySDCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#--
	
		def FindNthSubStringBetweenAsSectionsSDCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindNthSubStringBoundedByAsSectionsSDCSIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def NthSubStringBetweenSDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def NthSubStringBoundedBySDCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def NthSubStringBetweenAsSectionsSDCSIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBetweenSDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def NthSubStringBoundedByAsSectionsSDCSIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindNthSubStringBoundedBySDCSIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthSubStringBetweenSDIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindNthSubStringBetweenSDCSIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindNthSubStringBoundedBySDIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindNthSubStringBetweenAsSectionsSDIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindNthSubStringBoundedByAsSectionsSDIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def NthSubStringBetweenSDIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedBySDIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def NthSubStringBetweenAsSectionsSDIB(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindNthSubStringBetweenSDIBZZ(n, pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def NthSubStringBoundedByAsSectionsSDIB(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindNthSubStringBoundedBySDIBZZ(n, pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #-------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY   #
	 #  TWO OTHER SUBSTRINGS AND RETURNING THEM AS SECTIONS  #
	#-------------------------------------------------------#

	def FindFirstSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenCSZZ(pcSubStr, pcBounds, pcBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenCSZZ(pcSubStr, pcBounds[1], pcBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenAsSectionsCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindFirstSubStringBoundedByAsSectionsCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)

		#==

		def FirstSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FirstSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)

		def FirstSubStringBetweenAsSectionsCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FirstSubStringBoundedByAsSectionsCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)
		return This.FindFirstSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByZZ(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByZZ(pcSubStr, pacBounds)

		#--
	
		def FindFirstSubStringBetweenAsSections(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)

		def FindFirstSubStringBoundedByAsSections(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByZZ(pcSubStr, pacBounds)

		#==

		def FirstSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)

		def FirstSubStringBoundedByZZ(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByZZ(pcSubStr, pacBounds)

		def FirstSubStringBetweenAsSections(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)

		def FirstSubStringBoundedByAsSections(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByZZ(pcSubStr, pacBounds)

		#>

	  #--------------------------------------------------------------------------------------------#
	 #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS INCLUDING BOUNDS  #
	#--------------------------------------------------------------------------------------------#

	def FindFirstSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenCSIB(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return TThis.FindFirstSubStringBetweenCSIB(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindFirstSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSIB(pcSubStr, pacBound, pCaseSensitives)

		#==

		def FirstSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FirstSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
	
		def FirstSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FirstSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVE

	def FindFirstSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)
		return This.FindFirstSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByIB(pcSubStr, pacBounds)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenIB(pcSubStr, pacBounds, pacBounds)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return TThis.FindFirstSubStringBetweenIB(pcSubStr, pacBounds[1], pacBounds[2])

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenZIB(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)

		def FindFirstSubStringBoundedByZIB(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByIB(pcSubStr, pacBounds)

		#==

		def FirstSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)

		def FirstSubStringBoundedByIB(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByIB(pcSubStr, pacBounds)
	
		def FirstSubStringBetweenZIB(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)

		def FirstSubStringBoundedByZIB(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByIB(pcSubStr, pacBounds)

		#>

	   #-------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER           #
	 #  SUBSTRINGS INCLUDING BOUNDS AND RETURNING THEIR POSITIONS AS SECTIONS  #
	#-------------------------------------------------------------------------#

	def FindFirstSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenCSIBZZ(pcSubStr, pcBounds, pcBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenCSIBZZ(pcSubStr, pcBounds[1], pcBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenAsSectionsCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindFirstSubStringBoundedByAsSectionsCSIB(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)

		#==

		def FirstSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FirstSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)

		def FirstSubStringBetweenAsSectionsCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindFirstSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FirstSubStringBoundedByAsSectionsCSIB(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindFirstSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenZZIB(pcSubStr, pcBound1, pcBound2)
		return This.FindFirstSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def FindFirstSubStringBoundedByIBZZ(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		#--
	
		def FindFirstSubStringBetweenAsSectionsIB(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def FindFirstSubStringBoundedByAsSectionsIB(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		#==

		def FirstSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def FirstSubStringBoundedByIBZZ(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		def FirstSubStringBetweenAsSectionsIB(pcSubStr, pcBound1, pcBound2)
			return This.FindFirstSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def FirstSubStringBoundedByAsSectionsIB(pcSubStr, pacBounds)
			return This.FindFirstSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		#>
		
	   #------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY  #
	 #  TWO OTHER SUBSTRINGS STARTING AT A GIVEN POSITION   #
	#------------------------------------------------------#

	def FindFirstSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		/* ... */

		#< @FunctionalternativeForms

		def FindFirstSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenSCS(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenSCS(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindFirstSubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def FirstSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FirstSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FirstSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FirstSubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindFirstSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindFirstSubStringBetweenSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindFirstSubStringBoundedBySZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#==

		def FirstSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FirstSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		def FirstSubStringBetweenSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FirstSubStringBoundedBySZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#>

	   #---------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  STARTING AT A GIVEN POSITION AND RETURNING POSITIONS AS SECTIONS         #
	#---------------------------------------------------------------------------#

	def FindFirstSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenSCSZZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).isPairOfStrings()
				return This.FindFirstSubStringBetweenSCSZZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenAsSectionsSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindFirstSubStringBoundedByAsSectionsSCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def FirstSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FirstSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FirstSubStringBetweenAsSectionsSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FirstSubStringBoundedByAsSectionsSCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#--

	def FindFirstSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindFirstSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindFirstSubStringBetweenAsSectionsS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindFirstSubStringBoundedByAsSectionsS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#==

		def FirstSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FirstSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		def FirstSubStringBetweenAsSectionsS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FirstSubStringBoundedByAsSectionsS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#>

	   #----------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER  #
	 #  SUBSTRINGSSTARTING AT A GIVEN POSITION AND INCLUDING BOUNDS   #
	#----------------------------------------------------------------#

	def FindFirstSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenSCSIB(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenSCSIB(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindFirstSubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def FirstSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FirstSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FirstSubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FirstSubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindFirstSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindFirstSubStringBetweenSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindFirstSubStringBoundedBySIBZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#==

		def FirstSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FirstSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		def FirstSubStringBetweenSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FirstSubStringBoundedBySIBZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#>

	   #-------------------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS STARTING   #
	 #  AT A GIVEN POSITION, INCLUDING BOUNDS, AND RETURNING THE POSITIONS AS SECTIONS     #
	#-------------------------------------------------------------------------------------#

	def FindFirstSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenSCSIBZZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenSCSIBZZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be string or pair of strings.")

			ok

		#--
	
		def FindFirstSubStringBetweenAsSectionsSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindFirstSubStringBoundedByAsSectionsSCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def FirstSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FirstSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def FirstSubStringBetweenAsSectionsSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBetweenSIBCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FirstSubStringBoundedByAsSectionsSCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindFirstSubStringBetweenSIBCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindFirstSubStringBetweenAsSectionsSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindFirstSubStringBoundedByAsSectionsSIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#==

		def FirstSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FirstSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		def FirstSubStringBetweenAsSectionsSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindFirstSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FirstSubStringBoundedByAsSectionsSIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindFirstSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#>

	   #------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY  #
	 #  TWO OTHER SUBSTRINGS GOING IN A GIVEN DIRECTION     #
	#------------------------------------------------------#

	def FindFirstSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenDCS(pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenDCS(pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenDCSZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindFirstSubStringBoundedByDCSZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def FirstSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def FirstSubStringBetweenDCSZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByDCSZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindFirstSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindFirstSubStringBetweenDZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindFirstSubStringBoundedByDZ(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)

		#==

		def FirstSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FirstSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)

		def FirstSubStringBetweenDZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FirstSubStringBoundedByDZ(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)

		#>

	   #---------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  GOING INA GIVEN DIRECTION AND RETURNING POSITIONS AS SECTIONS            #
	#---------------------------------------------------------------------------#

	def FindFirstSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenDCSZZ(pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfNumbers()
				return This.FindFirstSubStringBetweenDCSZZ(pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindFirstSubStringBetweenAsSectionsDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindFirstSubStringBoundedByAsSectionsDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def FirstSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def FirstSubStringBetweenAsSectionsDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByAsSectionsDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindFirstSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindFirstSubStringBetweenAsSectionsD(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindFirstSubStringBoundedByAsSectionsD(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)

		#==

		def FirstSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FirstSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)

		def FirstSubStringBetweenAsSectionsD(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FirstSubStringBoundedByAsSectionsD(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)

		#>

	   #----------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER  #
	 #  SUBSTRINGS GOING IN A GIVEN DIRECTION AND INCLUDING BOUNDS    #
	#----------------------------------------------------------------#

	def FindFirstSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenDCSIB(pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenDCSIB(pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindFirstSubStringBetweenDCSIBZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindFirstSubStringBoundedByDCSIBZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def FirstSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def FirstSubStringBetweenDCSIBZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByDCSIBZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindFirstSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)
			return This.FindBoundedByDIB(pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindFirstSubStringBetweenDIBZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindFirstSubStringBoundedByDIBZ(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)

		#==

		def FirstSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FirstSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)

		def FirstSubStringBetweenDIBZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FirstSubStringBoundedByDIBZ(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)

		#>

	   #---------------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS GOING  #
	 #  IN A GIVENDIRECTION, INCLUDING BOUNDS, AND RETURNING POSITIONS AS SECTIONS     # 
	#---------------------------------------------------------------------------------#

	def FindFirstSubStringBetweenDCSIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenDCSIBZZ(pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfNumbers()
				return This.FindFirstSubStringBetweenDCSIBZZ(pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindFirstSubStringBetweenAsSectionsDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCSIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindFirstSubStringBoundedByAsSectionsDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def FirstSubStringBetweenDCSIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCSIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def FirstSubStringBetweenAsSectionsDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenDCIBSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByAsSectionsDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindFirstSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindFirstSubStringBetweenAsSectionsDIB(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindFirstSubStringBoundedByAsSectionsDIB(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)

		#==

		def FirstSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FirstSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)

		def FirstSubStringBetweenAsSectionsDIB(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindFirstSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FirstSubStringBoundedByAsSectionsDIB(pcSubStr, pacBounds, pcDirection)
			return This.FindFirstSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)

		#>

	   #---------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  STARTING AT A GIVEN POSITION AND GOING IN A GIVEN DIRECTION              #
	#---------------------------------------------------------------------------#

	def FindFirstSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenSDCS(pcSubStr, pacBounds, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

			but isLsit(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenSDCS(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindFirstSubStringBetweenSDCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindFirstSubStringBoundedBySDCSZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def FirstSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def FirstSubStringBetweenSDCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedBySDCSZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindFirstSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2,pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindFirstSubStringBetweenSDZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindFirstSubStringBoundedBySDZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def FirstSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def FirstSubStringBetweenSDZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedBySDZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #----------------------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING     #
	 #  AT A GIVEN POSITION, GOING IN A GIVEN DIRECTION, AND RETURNING POSITIONS AS SECTIONS  #
	#----------------------------------------------------------------------------------------#

	def FindFirstSubStringBetweenSDCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#--
	
		def FindFirstSubStringBetweenAsSectionsSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindFirstSubStringBoundedByAsSectionsSDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def FirstSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByAsSectionsSDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindFirstSubStringBetweenSDCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindFirstSubStringBetweenAsSectionsSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindFirstSubStringBoundedByAsSectionsSD(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def FirstSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def FirstSubStringBetweenAsSectionsSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedByAsSectionsSD(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #-------------------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING  #
	 #  AT A GIVEN POSITION, GOING IN A GIVEN DIRECTION, AND INCLUDING BOUNDS              #
	#-------------------------------------------------------------------------------------#

	def FindFirstSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindFirstSubStringBetweenSDCSIB(pcSubStr, pacBounds, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

			but isLsit(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindFirstSubStringBetweenSDCSIB(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindFirstSubStringBetweenSDCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindFirstSubStringBoundedBySDCSIBZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def FirstSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def FirstSubStringBetweenSDCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedBySDCSIBZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindFirstSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2,pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindFirstSubStringBetweenSDIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindFirstSubStringBoundedBySDIBZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def FirstSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def FirstSubStringBetweenSDIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedBySDIBZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #------------------------------------------------------------------------------------------------#
	  #  FINDING FIRST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING AT A GIVEN  #
	 #  POSITION, GOING IN A GIVEN DIRECTION, INCLUDING BOUNDS, AND RETURNING POSITIONS AS SECTIONS   #
	#------------------------------------------------------------------------------------------------#

	def FindFirstSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#--
	
		def FindFirstSubStringBetweenAsSectionsSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindFirstSubStringBoundedByAsSectionsSDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def FirstSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def FirstSubStringBetweenAsSectionsSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FirstSubStringBoundedByAsSectionsSDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindFirstSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindFirstSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirstSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindFirstSubStringBetweenAsSectionsSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindFirstSubStringBoundedByAsSectionsSDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def FirstSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def FirstSubStringBetweenAsSectionsSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FirstSubStringBoundedByAsSectionsSDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindFirstSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #-------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY    #
	 #  TWO OTHER SUBSTRINGS AND RETURNING THEM AS SECTIONS  #
	#-------------------------------------------------------#

	def FindLastSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenCSZZ(pcSubStr, pcBounds, pcBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenCSZZ(pcSubStr, pcBounds[1], pcBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenAsSectionsCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindLastSubStringBoundedByAsSectionsCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)

		#==

		def LastSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def LastSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)

		def LastSubStringBetweenAsSectionsCS(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def LastSubStringBoundedByAsSectionsCS(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSZZ(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)
		return This.FindLastSubStringBetweenCSZZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByZZ(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByZZ(pcSubStr, pacBounds)

		#--
	
		def FindLastSubStringBetweenAsSections(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)

		def FindLastSubStringBoundedByAsSections(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByZZ(pcSubStr, pacBounds)

		#==

		def LastSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)

		def LastSubStringBoundedByZZ(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByZZ(pcSubStr, pacBounds)

		def LastSubStringBetweenAsSections(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenZZ(pcSubStr, pcBound1, pcBound2)

		def LastSubStringBoundedByAsSections(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByZZ(pcSubStr, pacBounds)

		#>

	  #-------------------------------------------------------------------------------------------#
	 #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS INCLUDING BOUNDS  #
	#-------------------------------------------------------------------------------------------#

	def FindLastSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenCSIB(pcSubStr, pacBounds, pacBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return TThis.FindLastSubStringBetweenCSIB(pcSubStr, pacBounds[1], pacBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindLastSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSIB(pcSubStr, pacBound, pCaseSensitives)

		#==

		def LastSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def LastSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)
	
		def LastSubStringBetweenCSIBZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def LastSubStringBoundedByCSIBZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSIB(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVE

	def FindLastSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)
		return This.FindLastSubStringBetweenCSIB(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByIB(pcSubStr, pacBounds)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenIB(pcSubStr, pacBounds, pacBounds)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return TThis.FindLastSubStringBetweenIB(pcSubStr, pacBounds[1], pacBounds[2])

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenZIB(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)

		def FindLastSubStringBoundedByZIB(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByIB(pcSubStr, pacBounds)

		#==

		def LastSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)

		def LastSubStringBoundedByIB(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByIB(pcSubStr, pacBounds)
	
		def LastSubStringBetweenZIB(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenIB(pcSubStr, pcBound1, pcBound2)

		def LastSubStringBoundedByZIB(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByIB(pcSubStr, pacBounds)

		#>

	   #-------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER            #
	 #  SUBSTRINGS INCLUDING BOUNDS AND RETURNING THEIR POSITIONS AS SECTIONS  #
	#-------------------------------------------------------------------------#

	def FindLastSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenCSIBZZ(pcSubStr, pcBounds, pcBounds, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenCSIBZZ(pcSubStr, pcBounds[1], pcBounds[2], pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenAsSectionsCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def FindLastSubStringBoundedByAsSectionsCSIB(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)

		#==

		def LastSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def LastSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)

		def LastSubStringBetweenAsSectionsCSIB(pcSubStr, pcBound1, pcBound2, pCaseSensitive)
			return This.FindLastSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, pCaseSensitive)

		def LastSubStringBoundedByAsSectionsCSIB(pcSubStr, pacBounds, pCaseSensitive)
			return This.FindLastSubStringBoundedByCSIBZZ(pcSubStr, pacBounds, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenZZIB(pcSubStr, pcBound1, pcBound2)
		return This.FindLastSubStringBetweenCSIBZZ(pcSubStr, pcBound1, pcBound2, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def FindLastSubStringBoundedByIBZZ(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		#--
	
		def FindLastSubStringBetweenAsSectionsIB(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def FindLastSubStringBoundedByAsSectionsIB(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		#==

		def LastSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def LastSubStringBoundedByIBZZ(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		def LastSubStringBetweenAsSectionsIB(pcSubStr, pcBound1, pcBound2)
			return This.FindLastSubStringBetweenIBZZ(pcSubStr, pcBound1, pcBound2)

		def LastSubStringBoundedByAsSectionsIB(pcSubStr, pacBounds)
			return This.FindLastSubStringBoundedByIBZZ(pcSubStr, pacBounds)

		#>
		
	   #-----------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY  #
	 #  TWO OTHER SUBSTRINGS STARTING AT A GIVEN POSITION  #
	#-----------------------------------------------------#

	def FindLastSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		/* ... */

		#< @FunctionalternativeForms

		def FindLastSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenSCS(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenSCS(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindLastSubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def LastSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def LastSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def LastSubStringBetweenSCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def LastSubStringBoundedBySCSZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindLastSubStringBetweenSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindLastSubStringBetweenSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindLastSubStringBoundedBySZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#==

		def LastSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def LastSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		def LastSubStringBetweenSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenS(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def LastSubStringBoundedBySZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedByS(pcSubStr, pacBounds, pnStartingAt)

		#>

	   #--------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  STARTING AT A GIVEN POSITION AND RETURNING POSITIONS AS SECTIONS        #
	#--------------------------------------------------------------------------#

	def FindLastSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenSCSZZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).isPairOfStrings()
				return This.FindLastSubStringBetweenSCSZZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenAsSectionsSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindLastSubStringBoundedByAsSectionsSCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def LastSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def LastSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def LastSubStringBetweenAsSectionsSCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def LastSubStringBoundedByAsSectionsSCS(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#--

	def FindLastSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindLastSubStringBetweenSCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindLastSubStringBetweenAsSectionsS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindLastSubStringBoundedByAsSectionsS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#==

		def LastSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def LastSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		def LastSubStringBetweenAsSectionsS(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def LastSubStringBoundedByAsSectionsS(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySZZ(pcSubStr, pacBounds, pnStartingAt)

		#>

	   #--------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER  #
	 #  SUBSTRINGSSTARTING AT A GIVEN POSITION AND INCLUDING BOUNDS  #
	#---------------------------------------------------------------#

	def FindLastSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenSCSIB(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenSCSIB(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindLastSubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def LastSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def LastSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def LastSubStringBetweenSCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def LastSubStringBoundedBySCSIBZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindLastSubStringBetweenSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindLastSubStringBetweenSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindLastSubStringBoundedBySIBZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#==

		def LastSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def LastSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		def LastSubStringBetweenSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def LastSubStringBoundedBySIBZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySIB(pcSubStr, pacBounds, pnStartingAt)

		#>

	   #-----------------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS STARTING  #
	 #  AT A GIVEN POSITION, INCLUDING BOUNDS, AND RETURNING THE POSITIONS AS SECTIONS   #
	#-----------------------------------------------------------------------------------#

	def FindLastSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenSCSIBZZ(pcSubStr, pacBounds, pacBounds, pnStartingAt, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenSCSIBZZ(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be string or pair of strings.")

			ok

		#--
	
		def FindLastSubStringBetweenAsSectionsSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def FindLastSubStringBoundedByAsSectionsSCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#==

		def LastSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def LastSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		def LastSubStringBetweenAsSectionsSCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBetweenSIBCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pCaseSensitive)

		def LastSubStringBoundedByAsSectionsSCSIB(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)
			return This.FindLastSubStringBoundedBySCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
		return This.FindLastSubStringBetweenSIBCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#--
	
		def FindLastSubStringBetweenAsSectionsSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def FindLastSubStringBoundedByAsSectionsSIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#==

		def LastSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def LastSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		def LastSubStringBetweenAsSectionsSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt)
			return This.FindLastSubStringBetweenSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt)

		def LastSubStringBoundedByAsSectionsSIB(pcSubStr, pacBounds, pnStartingAt)
			return This.FindLastSubStringBoundedBySIBZZ(pcSubStr, pacBounds, pnStartingAt)

		#>

	   #-----------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY  #
	 #  TWO OTHER SUBSTRINGS GOING IN A GIVEN DIRECTION    #
	#-----------------------------------------------------#

	def FindLastSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenDCS(pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenDCS(pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenDCSZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindLastSubStringBoundedByDCSZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def LastSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def LastSubStringBetweenDCSZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByDCSZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindLastSubStringBetweenDCS(pcSubStr, pcBound1, pcBound2, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindLastSubStringBetweenDZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindLastSubStringBoundedByDZ(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)

		#==

		def LastSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)

		def LastSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)

		def LastSubStringBetweenDZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenD(pcSubStr, pcBound1, pcBound2, pcDirection)

		def LastSubStringBoundedByDZ(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByD(pcSubStr, pacBounds, pcDirection)

		#>

	   #--------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  GOING INA GIVEN DIRECTION AND RETURNING POSITIONS AS SECTIONS           #
	#--------------------------------------------------------------------------#

	def FindLastSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenDCSZZ(pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfNumbers()
				return This.FindLastSubStringBetweenDCSZZ(pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindLastSubStringBetweenAsSectionsDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindLastSubStringBoundedByAsSectionsDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def LastSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def LastSubStringBetweenAsSectionsDCS(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByAsSectionsDCS(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCSZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindLastSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindLastSubStringBetweenAsSectionsD(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindLastSubStringBoundedByAsSectionsD(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)

		#==

		def LastSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def LastSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)

		def LastSubStringBetweenAsSectionsD(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def LastSubStringBoundedByAsSectionsD(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDZZ(pcSubStr, pacBounds, pcDirection)

		#>

	   #---------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER  #
	 #  SUBSTRINGS GOING IN A GIVEN DIRECTION AND INCLUDING BOUNDS   #
	#---------------------------------------------------------------#

	def FindLastSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenDCSIB(pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenDCSIB(pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")
			ok

		#--
	
		def FindLastSubStringBetweenDCSIBZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindLastSubStringBoundedByDCSIBZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def LastSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def LastSubStringBetweenDCSIBZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByDCSIBZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindLastSubStringBetweenDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)
			return This.FindBoundedByDIB(pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindLastSubStringBetweenDIBZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindLastSubStringBoundedByDIBZ(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)

		#==

		def LastSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)

		def LastSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)

		def LastSubStringBetweenDIBZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDIB(pcSubStr, pcBound1, pcBound2, pcDirection)

		def LastSubStringBoundedByDIBZ(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDIB(pcSubStr, pacBounds, pcDirection)

		#>

	   #--------------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS GOING  #
	 #  IN A GIVENDIRECTION, INCLUDING BOUNDS, AND RETURNING POSITIONS AS SECTIONS    # 
	#--------------------------------------------------------------------------------#

	def FindLastSubStringBetweenDCSIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenDCSIBZZ(pcSubStr, pacBounds, pacBounds, pcDirection, pCaseSensitive)

			but isList(pacBounds) and Q(pacBounds).IsPairOfNumbers()
				return This.FindLastSubStringBetweenDCSIBZZ(pcSubStr, pacBounds[1], pacBounds[2], pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindLastSubStringBetweenAsSectionsDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCSIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def FindLastSubStringBoundedByAsSectionsDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#==

		def LastSubStringBetweenDCSIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCSIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		def LastSubStringBetweenAsSectionsDCSIB(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenDCIBSZZ(pcSubStr, pcBound1, pcBound2, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByAsSectionsDCSIB(pcSubStr, pacBounds, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedByDCSIBZZ(pcSubStr, pacBounds, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)
		return This.FindLastSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)

		#--
	
		def FindLastSubStringBetweenAsSectionsDIB(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def FindLastSubStringBoundedByAsSectionsDIB(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)

		#==

		def LastSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def LastSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)

		def LastSubStringBetweenAsSectionsDIB(pcSubStr, pcBound1, pcBound2, pcDirection)
			return This.FindLastSubStringBetweenDIBZZ(pcSubStr, pcBound1, pcBound2, pcDirection)

		def LastSubStringBoundedByAsSectionsDIB(pcSubStr, pacBounds, pcDirection)
			return This.FindLastSubStringBoundedByDIBZZ(pcSubStr, pacBounds, pcDirection)

		#>

	   #--------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGS  #
	 #  STARTING AT A GIVEN POSITION AND GOING IN A GIVEN DIRECTION             #
	#--------------------------------------------------------------------------#

	def FindLastSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenSDCS(pcSubStr, pacBounds, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

			but isLsit(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenSDCS(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindLastSubStringBetweenSDCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindLastSubStringBoundedBySDCSZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def LastSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def LastSubStringBetweenSDCSZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def LastSubStringBoundedBySDCSZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindLastSubStringBetweenSDCS(pcSubStr, pcBound1, pcBound2,pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindLastSubStringBetweenSDZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindLastSubStringBoundedBySDZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def LastSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def LastSubStringBetweenSDZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedBySDZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySD(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #----------------------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING      #
	 #  AT A GIVEN POSITION, GOING IN A GIVEN DIRECTION, AND RETURNING POSITIONS AS SECTIONS  #
	#----------------------------------------------------------------------------------------#

	def FindLastSubStringBetweenSDCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#--
	
		def FindLastSubStringBetweenAsSectionsSDCS(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindLastSubStringBoundedByAsSectionsSDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def LastSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByAsSectionsSDCS(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindLastSubStringBetweenSDCSZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindLastSubStringBetweenAsSectionsSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindLastSubStringBoundedByAsSectionsSD(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def LastSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def LastSubStringBetweenAsSectionsSD(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedByAsSectionsSD(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #-----------------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING #
	 #  AT A GIVEN POSITION, GOING IN A GIVEN DIRECTION, AND INCLUDING BOUNDS            #
	#-----------------------------------------------------------------------------------#

	def FindLastSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			if isString(pacBounds)
				return This.FindLastSubStringBetweenSDCSIB(pcSubStr, pacBounds, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

			but isLsit(pacBounds) and Q(pacBounds).IsPairOfStrings()
				return This.FindLastSubStringBetweenSDCSIB(pcSubStr, pacBounds[1], pacBounds[2], pnStartingAt, pcDirection, pCaseSensitive)

			else
				StzRaise("Incorrect param type! pacBounds must be a string or pair of strings.")

			ok

		#--
	
		def FindLastSubStringBetweenSDCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindLastSubStringBoundedBySDCSIBZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def LastSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def LastSubStringBetweenSDCSIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def LastSubStringBoundedBySDCSIBZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindLastSubStringBetweenSDCSIB(pcSubStr, pcBound1, pcBound2,pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindLastSubStringBetweenSDIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindLastSubStringBoundedBySDIBZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def LastSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def LastSubStringBetweenSDIBZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedBySDIBZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

	   #-----------------------------------------------------------------------------------------------#
	  #  FINDING LAST OCCURRENCE OF A SUBSTRING BOUNDED BY TWO OTHER SUBSTRINGSS STARTING AT A GIVEN  #
	 #  POSITION, GOING IN A GIVEN DIRECTION, INCLUDING BOUNDS, AND RETURNING POSITIONS AS SECTIONS  #
	#-----------------------------------------------------------------------------------------------#

	def FindLastSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
		/* ... */

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#--
	
		def FindLastSubStringBetweenAsSectionsSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def FindLastSubStringBoundedByAsSectionsSDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#==

		def LastSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def LastSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		def LastSubStringBetweenAsSectionsSDCSIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, pCaseSensitive)

		def LastSubStringBoundedByAsSectionsSDCSIB(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)
			return This.FindLastSubStringBoundedBySDCSIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
		return This.FindLastSubStringBetweenSDCSIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindLastSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#--
	
		def FindLastSubStringBetweenAsSectionsSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def FindLastSubStringBoundedByAsSectionsSDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#==

		def LastSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		def LastSubStringBetweenAsSectionsSDIB(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)
			return This.FindLastSubStringBetweenSDIBZZ(pcSubStr, pcBound1, pcBound2, pnStartingAt, pcDirection)

		def LastSubStringBoundedByAsSectionsSDIB(pcSubStr, pacBounds, pnStartingAt, pcDirection)
			return This.FindLastSubStringBoundedBySDIBZZ(pcSubStr, pacBounds, pnStartingAt, pcDirection)

		#>

