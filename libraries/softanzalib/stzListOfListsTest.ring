load "stzlib.ring"

# CHANGED HAVE BEEN MADE ELSWHERE, NOT REPORTED YET HERE!

/*-----------------
*/
o1 = new stzListOfLists([
	1:2, 1:3, [9,9,9], 1:4, 1:5, [9,9,9], 1:7, 1:8, [9,9,9]
])


? o1.FindAll([9,9,9])
#--> [3, 6, 9]

# Note: the following functions work the same for stzString, 
# stzList, and stzListOfStrings, because they are abstracted in stzObject

? o1.NFirstOccurrences(2, :Of = [9,9,9]) 
#--> [3, 6]

? o1.NFirstOccurrencesXT(2, :Of = [9,9,9], :StartingAt = 1)
#--> [3, 6]

? o1.NLastOccurrences(2, :Of = [9,9,9])
#--> [6, 9]

? o1.NLastOccurrencesXT(2, [9,9,9], :StartingAt = 1)
#--> [6, 9]

? o1.NFirstOccurrencesXT(2, :Of = [9,9,9], :StartingAt = 6)
#--> [6, 9]

? o1.LastNOccurrencesXT(2, :Of = [9,9,9], :StartingAt = 10)
#--> [6, 9]

/*-----------

? @@S( StzListQ( 4:8 ).ToListInString() )
#--> "[ 4, 5, 6, 7, 8 ]"

? @@S( StzListQ( 4:8 ).ToListInStringInShortForm() )
#--> "4 : 8"

/*-----------
*
o1 = new stzListOfLists([ 1:3, 4:5, 6:7 ])
? @@S( o1.ToListInString() )
#--> "[ [ 1, 2, 3 ], [ 4, 5 ], [ 6, 7 ] ]"

? @@S( o1.ToListInStringInShortForm() )
#--> [ "1 : 3", "4 : 5", "6 : 7" ]

/*----------

o1 = new stzListOfLists([
	[ 1, 2, 3 ],
	[ 4, 5, 6, 7, 8 ],
	[ 9, 0 ],
	[ 3, 5 ],
	[ 5, 6, 7 ]
])

? o1.NthList(4) 			#--> [3, 5]

? @@S( o1.ItemsAtPositionN(2) ) 	# --> [ 2, 5, 0, 5, 6 ]

? @@S( o1.ListsOfSize(2) )		# --> [ [9,0], [3,5] ]
? o1.PositionsOfListsOfSize(2)		# --> [     3,    4  ]

? @@S( o1.Sizes() )			# --> [ 3, 5, 2, 2, 3 ]
? o1.SmallestSize()			# --> 2
? o1.BiggestSize()			# --> 5

? @@S( o1.SmallestLists() )		# --> [ [9,0], [3,5] ]
? o1.PositionsOfSmallestLists()		# --> [     3,    4  ]

? @@S( o1.ListsW('StzListQ(@list).NumberOfItems() <= 3') )
# --> [ [ 1, 2, 3 ], [ 9, 0 ], [ 3, 5 ], [ 5, 6, 7 ] ]

? @@S( o1.Yield('{ len(@list) }') ) 	# --> [ 3, 5, 2, 2, 3 ]

/*---------- TODO: check why they are not merged and flattened!

// Merging many lists in one list
o1 = new stzListOfLists([ 1:3, 4:7, 8:9, [10, 11:13] ])

o1.MergeAndFlatten()
? @@S( o1.Content() )

/*---------- ERROR: Undefined function

// Indexing those three lists

a1 = [ "A", "B", "A" ]
a2 = [ "A", "B", "C" ]
a3 = [ "C", "D", "A" ]

o1 = new stzListOfLists([ a1, a2, a3 ])

# First on the positions occuppied by each item in each list

aIndex = o1.IndexOn(:Position)	# ERROR: Undefined function

# Gives:
#	[ :A = [ [1,1], [1,3], [2,1], [3,3] ],
#	  :B = [ [1,2], [2,2] ],
#	  :C = [ [2,3], [3,1] ]
#      	]	

? aIndex["A"] # Showing just the index of "A"

// And second on number of occurrence of each character in each list

aIndex = o1.IndexOn(:NumberOfOccurrence)

# Gives:
#	[ :A = [2, 1, 1],
#	  :B = [1, 1, 0],
#	  :C = [0, 1, 1]
#      	]	

? aIndex["C"] #  # Showing just the index of "C"




