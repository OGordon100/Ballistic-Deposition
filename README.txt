----------------------------------
|  Ballistic Deposition Project  |
|  Oliver Gordon, 4224942        |
----------------------------------

----------------------------------
Ballistic_Report.docx/Ballistic_Report.pdf
	- Report, ~3350 words
--------------------------
----------------------------------
Ballistic_General.m 
	- Generic file that allows multiple different sticking models to be combined
	- To combine different models, uncomment relevant code
--------------------------
----------------------------------
Ballistic_Cone.m
	- Allows generation from any seed desired with no added frills.
	- Used in conclusion
--------------------------
----------------------------------
NORMAL FOLDER
	- Ballistic_Normal.m
		- Used to demonstrate that model works as intended
		- Set up to do 2 repeats of a new setup and write results to new folder and file (should take 2-3 seconds)
	- Ballistic_Normal_Analyse.m
		- Used to read in repeat data produced by Ballistic_Normal.m and average 
		- WILL NOT RUN WITHOUT RUNNING NORMAL CODE FIRST
		- Run Ballistic_Normal.m to generate sample data for this to average out
	- Ballistic_Normal_Analyse_Analyse.m
		- Used to plot averaged data
		- Will work with averaged data in folders included; press run and go!
	- Ballistic_Normal_Calc
		- I used this to plot stuff to find alpha
		- Hideous formatting, but I included it so you can replicate the
		  curve fit to find alpha
--------------------------
----------------------------------
PROBABILITY FOLDER
	- As above, but for probability of dropping
--------------------------
----------------------------------
HEIGHT FOLDER
	- My incorrect model of height based sticking
	- I included it for reference; it works, and is set up to just generate multiple figures
	  for the graph I decided to include
	- sorry :( 
--------------------------
----------------------------------
ANGLE FOLDER
	- As before, BUT
		- Angle code is not set up to output any results to file
		- I included the stuff I generated because it may be of interest, even though it's
		  clearly wrong and therefore wasn't included in the report.
	- There is a 'try' function in here. For some reason on some versions of MATLAB there is a 
	possibility of crashing before the matrix gets out of the triangle made by the angle base.
	pause(0.2) fixes it some but not all of the time.
	- If this happens, uncomment lines 88,92-94
--------------------------

Thanks

- Oliver