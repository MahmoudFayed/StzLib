load "../string/stkStringArt.ring"

decimals(3)
t0 = clock()

# NOTE This sampe (and the stkStringArt itself) is dedicated to
# Mahmoud for the efforts he deplyed in delivering V1.21 of Ring

? StringArt("THANK") + nl
? StringArt("YOU") + nl
? StringArt("MAHMOUD!")

#-->
'
███████░░░██░░░██░░░░▄███▄░░░░██░░░██░░░██░░░██░░░
░░██░░░░░░██░░░██░░░██▀░▀██░░░███░░██░░░██░░██░░░░
░░██░░░░░░███████░░░███████░░░██▀█░██░░░█████░░░░░
░░██░░░░░░██░░░██░░░██░░░██░░░██░▀███░░░██░░██░░░░
░░██░░░░░░██░░░██░░░██░░░██░░░██░░░██░░░██░░░██░░░

██░░░██░░░░▄███▄░░░░██░░░██░░░
░██░██░░░░██▀░▀██░░░██░░░██░░░
░░███░░░░░██░░░██░░░██░░░██░░░
░░██░░░░░░██▄░▄██░░░██▄░▄██░░░
░░██░░░░░░░▀███▀░░░░░▀███▀░░░░

██░░░██░░░░▄███▄░░░░██░░░██░░░██░░░██░░░░▄███▄░░░░██░░░██░░░███▄▄░░░░░██░░░░
███░███░░░██▀░▀██░░░██░░░██░░░███░███░░░██▀░▀██░░░██░░░██░░░██░░░██░░░██░░░░
██▀█▀██░░░███████░░░███████░░░██▀█▀██░░░██░░░██░░░██░░░██░░░██░░░██░░░██░░░░
██░░░██░░░██░░░██░░░██░░░██░░░██░░░██░░░██▄░▄██░░░██▄░▄██░░░██░░░██░░░░░░░░░
██░░░██░░░██░░░██░░░██░░░██░░░██░░░██░░░░▀███▀░░░░░▀███▀░░░░███▄▄░░░░░██░░░░
'

? NL + "~~~~~~~"

t = (clock() - t0) / clockspersecond()
? "Executed in " + t + " seconds."
