func StzListOfHashListsQ(paList)
	return new stzListOfHashLists(paList)

func StzHashListsQ(paList)
	return new stzListOfHashLists(paList)


class stzHashLists from stzListOfHashLists
class stzListOfAssociativeLists from stzListOfHashLists
class stzAssociativeLists from stzListOfHashLists

class stzListOfHashLists from stzList
	@aListOfHashLists

	def init(paList)
		if isList(paList) and
		   ( Q(paList).IsEmpty() or Q(paList).IsListOfHashLists() )

			@aListOfHashLists = paList

		else
			StzRaise("Can't create stzListOfHashLists object!")
		ok

	def Content()
		return @aListOfHashLists

		def Value()
			return Content()

	def Copy()
		return new stzListOfHashLists(This.Content())

	def ListOfHashLists()
		return This.Content()

	def Show()
		for aHashList in This.ListOfHashLists()
			StzHashListQ(aHashList).Show() ? ""
		next

		#< @FuntionMisspelledForm

		def Shwo()
			This.Show()

		#>
