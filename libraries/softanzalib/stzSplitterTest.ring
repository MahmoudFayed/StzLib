load "stzlib.ring"

/*====================
*/
o1 = new stzSplitter(1:10)

? @@S( o1.SplitAfter( :Position = 5) )
#--> [ [ 1, 5 ], [ 6, 10 ] ]

? @@S( o1.SplitAfter([3, 7]) )
#--> [ [ 1, 3 ], [ 4, 7 ], [ 8, 10 ] ]

? @@S( o1.SplitAfterSection([ 4, 7 ]) )
#--> [ [ 1, 7 ], [ 8, 10 ] ]

? @@S( o1.SplitAfterSection([ 2, 9 ]) ) #!!!!
#!--> [ [ 1, 9 ], [ 10, 10 ] ]

? @@S( o1.SplitAfterSections([ [3,5], [7, 8] ]) )
#--> [ [ 1, 5 ], [ 6, 8 ], [ 9, 10 ] ]

? @@S( o1.SplitAfter( :Sections = [ [3,5], [7, 8] ] ) )
#--> [ [ 1, 5 ], [ 6, 8 ], [ 9, 10 ] ]

? @@S( o1.SplitAfter( :Section = [ 4, 6 ] ) )
#--> [ [ 1, 6 ], [ 7, 10 ] ]

? @@S( o1.SplitAfter( :Sections = [ [ 4, 6 ] ] ) )
#--> [ [ 1, 6 ], [ 7, 10 ] ]

/*====================

o1 = new stzSplitter(1:10)

? @@S( o1.SplitBefore( :Position = 5) )
#--> [ [1, 4], [5, 10] ]

? @@S( o1.SplitBefore([3, 7]) )
#--> [ [ 1, 2 ], [ 3, 6 ], [ 7, 10 ] ]

? @@S( o1.SplitBeforeSection([ 4, 7 ]) )
#--> [ [ 1, 3 ], [ 4, 10 ] ]

? @@S( o1.SplitBeforeSection([ 1, 9 ]) )
#--> [ [ 1, 10 ] ]

? @@S( o1.SplitBeforeSections([ [3,5], [7, 8] ]) )
#--> [ [ 1, 2 ], [ 3, 6 ], [ 7, 10 ] ]

? @@S( o1.SplitBefore( :Sections = [ [3,5], [7, 8] ] ) )
#--> [ [ 1, 2 ], [ 3, 6 ], [ 7, 10 ] ]

? @@S( o1.SplitBefore( :Section = [ 4, 6 ] ) )
#--> [ [ 1, 3 ], [ 4, 10 ] ]

? @@S( o1.SplitBefore( :Sections = [ [ 4, 6 ] ] ) )
#--> [ [ 1, 3 ], [ 4, 10 ] ]

/*====================

o1 = new stzSplitter(1:10)

? @@S( o1.SplitAt( :Position = 5) )
#--> [ [1, 4], [6, 10] ]

? @@S( o1.SplitAt([3, 7]) )
#--> [ [ 1, 2 ], [ 4, 6 ], [ 8, 10 ] ]

? @@S( o1.SplitAtSection([ 4, 7 ]) )
#--> [ [ 1, 3 ], [ 8, 10 ] ]

? @@S( o1.SplitAtSection([ 1, 9 ]) )
#--> [ [ 10, 10 ] ]

? @@S( o1.SplitAtSections([ [3,5], [7, 8] ]) )
#--> [ [1, 2], [6, 6], [9, 10] ]

? @@S( o1.SplitAt( :Sections = [ [3,5], [7, 8] ] ) )
#--> [ [1, 2], [6, 6], [9, 10] ]

? @@S( o1.SplitAt( :Section = [ 4, 6 ] ) )
#--> [ [ 1, 3 ], [ 7, 10 ] ]

? @@S( o1.SplitAt( :Sections = [ [ 4, 6 ] ] ) )
#--> [ [ 1, 3 ], [ 7, 10 ] ]

/*====================

o1 = new stzSplitter(1:10)

? @@S( o1.Split( :At = 5) )
#--> [ [1, 4], [6, 10] ]

? @@S( o1.Split( :At = [3, 7] ) )
#--> [ [ 1, 2 ], [ 4, 6 ], [ 8, 10 ] ]

? @@S( o1.Split( :AtSection = [ 4, 7 ]) )
#--> [ [ 1, 3 ], [ 8, 10 ] ]

? @@S( o1.Split( :AtSection = [ 1, 9 ]) )
#--> [ [ 10, 10 ] ]

? @@S(o1.Split( :AtSections = [ [3,5], [7, 8] ] ))
#--> [ [1, 2], [6, 6], [9, 10] ]

? @@S( o1.Split( :Before = 5 ) )
#--> [ [ 1, 4 ], [ 5, 10 ] ]

? @@S( o1.Split( :Before = [3, 7] ) )
#--> [ [ 1, 2 ], [ 3, 6 ], [ 7, 10 ] ]

? @@S( o1.Split( :After = 5 ) )
#--> [ [ 1, 5 ], [ 6, 10 ] ]

? @@S( o1.Split( :After = [3, 7] ) )
#--> [ [ 1, 3 ], [ 4, 7 ], [ 8, 10 ] ]

? @@S( o1.Split( :ToPartsOfNItems = 3 ) )
#--> [ [ 1, 3 ], [ 4, 6 ], [ 7, 9 ], [ 10, 10 ] ]

? @@S( o1.Split( :ToPartsOfExactlyNItems = 3 ) )
#--> [ [ 1, 3 ], [ 4, 6 ], [ 7, 9 ] ]

? @@S( o1.Split( :ToNParts = 4 ) )
# --> [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 7, 10 ] ]

/*==================

o1 = new stzString("_♥_★_♥_")

? @@S( o1.FindMany([ "♥", "★" ]) )
#--> [ 2, 4, 6 ]

o1 = new stzList([ "_", "♥", "_", "★", "_", "♥" ])
? @@S( o1.FindMany([ "♥", "★" ]) )
#--> [ 2, 4, 6 ]

o1 = new stzString("_♥_★_♥_")
? @@S( o1.FindManyXT([ "♥", "★" ]) )
#--> [ [ "♥", [ 2, 6 ] ], [ "★", [ 4 ] ] ]

o1 = new stzList([ "_", "♥", "_", "★", "_", "♥" ])
? @@S( o1.FindManyXT([ "♥", "★" ]) )
#--> [ [ "♥", [ 2, 6 ] ], [ "★", [ 4 ] ] ]


/*--------------------

o1 = new stzSplitter(1:10)
? @@S( o1.Split( :AtSections = [ [3,5], [8,9] ] ) )
#--> [ [ 1, 2 ], [ 6, 7 ], [ 10, 10 ] ]

/*--------------------

o1 = new stzListOfPairs([ [ 9, 10 ], [ 1, 2 ], [ 6, 6 ] ])
o1.SortInAscending()
? @@S( o1.Content() )
#--> [ [ 1, 2 ], [ 6, 6 ], [ 9, 10 ] ]


/*------------------

? @@S( o1.SplitBefore(5) )
#--> [ [ 1, 4 ], [ 5, 10 ] ]

? @@S( o1.SplitBefore([ 3, 6, 8]) )
#--> [ [ 1, 2 ], [ 3, 5 ], [ 6, 7 ], [ 8, 10 ] ]

/*------------------

? @@S( o1.SplitAfter(5) )
#--> [ [ 1, 5 ], [ 6, 10 ] ]

? @@S( o1.SplitAfter([ 3, 6, 8]) )
#--> [ [ 1, 3 ], [ 4, 6 ], [ 7, 8 ], [ 9, 10 ] ]

/*==================

? @@S( o1.SplitToNParts(2) )
#--> [ [ 1, 5 ], [ 6, 10 ] ]

/*
? @@S( o1.SplitToPartsOfNPositions(2) )
# --> [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 7, 8 ], [ 9, 10 ] ]

? @@S( o1.SplitToPartsOfNPositions(3) )
#--> [ [ 1, 3 ], [ 4, 6 ], [ 7, 9 ], [ 10, 10 ] ]

? @@S( o1.SplitToPartsOfExactlyNPositions(3) )
#--> [ [ 1, 3 ], [ 4, 6 ], [ 7, 9 ] ]

o1 = new stzSplitter(12)
? @@S( o1.SplitToPartsOfNPositions(5) )
#--> [ [ 1, 5 ], [ 6, 10 ], [ 11, 12 ] ]

? @@S( o1.SplitToPartsOfExactlyNPositions(5) )
#--> [ [ 1, 5 ], [ 6, 10 ] ]

/*==================

# Softanza is designed with Programmer Experience in mind.

# We all forget a function syntax and how parameters should
# be organized. We could make a trial or two before that
# hopefully works. Or we interrup the programming process
# and turn to documentation to get help...

# To avoid that, Softanza usually incorporates many alternatives
# of the same function. This allows it to be flexible and permissive:
# Whatever comes to your mind expressing your intent, the library
# will do its best to understood it and execute it!

# All the following formulations lead to the same result:
# splitting at a some positions given by a conditional expression...

o1 = new stzList( 1:10 )

? @@S( o1.SplitW( 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 2 ], [ 4, 5 ], [ 7, 8 ], [ 10, 10 ] ]

? @@S( o1.SplitW( :Where = 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 2 ], [ 4, 5 ], [ 7, 8 ], [ 10, 10 ] ]

? @@S( o1.SplitW( :At = 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 2 ], [ 4, 5 ], [ 7, 8 ], [ 10, 10 ] ]

? @@S( o1.SplitAtW( :Where = 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 2 ], [ 4, 5 ], [ 7, 8 ], [ 10, 10 ] ]

? @@S( o1.SplitAtW( 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 2 ], [ 4, 5 ], [ 7, 8 ], [ 10, 10 ] ]

/*------------------

? @@S( o1.SplitW( :Before = 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 2 ], [ 3, 5 ], [ 6, 8 ], [ 9, 10 ] ]

? @@S( o1.SplitBeforeW( 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 2 ], [ 3, 5 ], [ 6, 8 ], [ 9, 10 ] ]

? @@S( o1.SplitBeforeW( :Where = 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 2 ], [ 3, 5 ], [ 6, 8 ], [ 9, 10 ] ]

/*------------------

? @@S( o1.SplitW( :After = 'Q(@position).IsMultipleOf(3)' ) )
#--> 

? @@S( o1.SplitAfterW( 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 3 ], [ 4, 6 ], [ 7, 9 ], [ 10, 10 ] ]

? @@S( o1.SplitAfterW( :Where = 'Q(@position).IsMultipleOf(3)' ) )
#--> [ [ 1, 3 ], [ 4, 6 ], [ 7, 9 ], [ 10, 10 ] ]

/*==================

? @@S( o1.SplitToNParts(4) )
# --> [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 7, 10 ] ]

/*==================

? @@S( o1.GetPairsFromPositions([3, 6, 8]) )
# --> [ [ 1, 3 ], [ 3, 6 ], [ 6, 8 ], [ 8, 10 ] ]


