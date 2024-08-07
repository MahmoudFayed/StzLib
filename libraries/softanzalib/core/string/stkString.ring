load "LightGuiLib.ring"

#~~~~~~~~~~~~~~~~~~~#
#  STZ CORE STRING  #
#~~~~~~~~~~~~~~~~~~~#

class stkString from stzCoreString

class stzCoreString from stzCoreObject
	@content // A QString object from Qt

	def init(str)
		if NOT isString(str)
			return StkError(:IncorrectPramType)
		ok

		@content = new QString2()
		@content.append(str)

	#--

	def Content()
		return @content.mid(0, @content.count())

	#--

	def Size()
		return @content.count()

		def Count()
			return @content.count()

		def NumberOfChars()
			return @content.count()

	#--

	def At(n)
		return @content.mid(n-1, 1)

		def CharAt(n)
			return @content.mid(n-1, 1)

	#-- APPENDING

	def Append(substr)
		@content.append(substr)

		def Add(substr)
			@content.append(substr)

	def AppendQChar(q)
		@content.append_2(q)

	#-- FINDING

	def FindFirstCS(substr, bCase)
		return @content.indexOf(substr, 0, bCase) + 1

	def FindFirst(substr)
		return @content.indexOf(substr, 0, true) + 1

	#--

	def FindLastCS(substr, bCase)
		return @content.lastIndexOf(substr, @content.count()-1, bCase) + 1

	def FindLast(substr)
		return @content.lastIndexOf(substr, @content.count()-1, true) + 1

	#--

	def FindCS(substr, bCase)
		@TempQStr = new QString2()
		@TempQStr.append(substr)
		nSize = @TempQStr.count()

		anResult = []
		bContinue = TRUE
	
		nPos = 0  # Start from index 0
	
	   	while bContinue
			nPos = @content.indexOf(substr, nPos, bCase)
			if nPos = -1
				bContinue = FALSE
			else
				anResult + (nPos + 1)  	# Add 1 to convert to 1-based index
				nPos = nPos + nSize  	# Move to the next position after the found substring
			ok
		end
	
		return anResult


		def FindAllCS(substr, bCase)
			return This.FindCS(substr, bCase)

	def Find(substr)
		return This.FindCS(substr, true)

		def FindAll(substr)
			return This.Find(substr)

	#--

	def FindNthCS(n, substr, bCase)
		@TempQStr = new QString2()
		@TempQStr.append(substr)
		nSize = @TempQStr.count()

		nResult = 0
		bContinue = TRUE
	
		nPos = 0  # Start from index 0
		nTimes = 0

	   	while bContinue
			nPos = @content.indexOf(substr, nPos, bCase)
			if nPos = -1
				bContinue = FALSE
			else
				nTimes++ 
				if nTimes = n
					nResult = nPos + 1
					exit
				ok

				nPos = nPos + nSize  	# Move to the next position after the found substring
			ok
		end
	
		return nResult

	def FindNth(n, substr)
		return This.FindNthCS(n, substr, true)
	
	#-- INSERTING

	def InsertAt(n, substr)
		@content.insert(n-1, substr)

	#== REPLACING

	def ReplaceCS(substr1, substr2, bCase)
		@content.replace_2(substr1, substr2, bCase)

	def Replace(substr1, substr2)
		@content.replace_2(substr1, substr2, true)

	#--

	def ReplaceSection(n1, n2, substr)
		@content.replace( n1 - 1, n2 - n1 + 1, substr)

	#== REMOVING

	def RemoveCS(substr, bCase)
		@content.replace_2(substr, "", bCase)

	def Remove(substr)
		@content.replace_2(substr, "", true)

	#--

	def RemoveSection(n1, n2)
		@content.replace(n1 - 1, n2 - n1 + 1, "")

	#== SPLITTING

	def SplitCS(substr, bCase)
		oQStrList = This.QStringObject().split(substr, 0, bCase)

		acResult = []
		for i = 0 to oQStrList.size()-1
			acResult + oQStrList.at(i)	
		next
	
		return acResult

	def Split(substr)
		return This.SplitCS(substr, true)

	#--

	def Section(n1, n2)
		return @content.mid(n1-1, n2 - n1 + 1)

	#--

	def ContainsCS(substr, bCase)
		return @content.contains(substr, bCase)

	def Contains(substr)
		return @content.contains(substr, true)

	#==

	def StartsWithCS(substr, bCase)
		return @content.startsWith(substr, bCase)

	def StartsWith(substr)
		return @content.startsWith(substr, true)

	#--

	def EndsWithCS(substr, bCase)
		return @content.endsWith(substr, bCase)

	def EndsWith(substr)
		return @content.endsWith(substr, true)

	#--

	def IsRightToLeft()
		return @content.IsRighttoLeft()

	#--

	def Simplify()
		cSimplified = @content.simplified()
		oTempQStr = new QString2()
		oTempQStr.append(cSimplified)

		@content = oTempQStr

	#==

	def UnicodeAt(n)
		oTempQStr = new QString2()
		oTempQStr.append(This.CharAt(n))
		nResult = oTempQStr.unicode().unicode()
		return nResult

		def UnicodeOfCharAt(n)
			return This.UnicodeOfChar(n)

	def Unicode()
		if This.Size() = 1
			return This.UnicodeAt(1)
		else
			return This.Unicodes()
		ok

	def Unicodes()
		anResult = []
		nLen = This.Size()

		for i = 1 to nLen
			anResult + This.UnicodeAt(i)
		next

		return anResult

	def Chars()
		acResult = []
		nLen = This.Size()

		for i = 1 to nLen
			acResult + This.CharAt(i)
		next

		return acResult

	#==

	def QStringObject()
		return @content

		def Qt()
			return @content

	def ToQCharObject(n)
		return new QChar(This.UnicodeAt(n))

		def ToQChar(n)
			return new QChar(This.UnicodeAt(n))

		def QCharObject(n)
			return new QChar(This.UnicodeAt(n))

		def QChar(n)
			return new QChar(This.UnicodeAt(n))

	#==

	def Operator(op, value)
		if op = "+"
			@content.append(value)

		but op = "[]"
			return This.At(value)

		else
			raise( 'ERR-' + StkError(:UnsupportedOperator) )
		ok
