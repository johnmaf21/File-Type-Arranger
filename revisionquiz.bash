#! /bin/bash
#revisionquiz - this is a prgrom which reads a textfile that has already been created, outputs the questions
################and takes in an user input for the answers. It also calculates their score and tells them
################if their answer is wrong.
#Author = John-Calvin Mafura
#Email = <u1874295@unimail.hud.ac.uk>
#Date = 1/12/2018

#check to see if only obne argument has been inputted
if [ $# -ne 1 ]
then
	echo  ${0##*/}" needs a single arguements which is a textfile."
	echo "USEAGE: "${0##*/}" [ *name of the quiz* ]"
else
	#variable contain the text file quiz
	filename=$1
	#variable contain the current file type
	filetype=$(file -0 $filename | cut -d $'\0' -f2)
	#check to see if it is a text file
	if [[ $filetype == *"ASCII"* ]]
	then
		#check to see if it has/nt got quiz in it's name 
		if [[ $filename != *"quiz"* ]]
		then
			#userinputs whether it is a quiz or not
			read -p "Are you sure this is a quiz. y for yes. n for no: " isQuiz
			#checks if the users inputs no
			if [[ $isQuiz == "n" ]]
			then
				echo "Exiting now"
				exit
			fi
		fi
		#makes file executable
		chmod 777 $filename
		score=0
		#the total amount of lines in filename
		lines=$(cat $filename | wc -l)
		#variable that will contain the question
		question=""
		#variable that will contain the answer
		answers=""
		#variable that will contain the amount of questions asked
		numofquestions=0
		echo "Hello. Welcome to this revision quiz"
		echo "Once a question is asked, put your answer below and press enter"
		#for loop in range 1 to total of lines in filename with skip of 2
		for i in $(seq 1 2 $lines)
		do
			#increment number of questions
			numofquestions=$((numofquestions+1))
			#variable now conatains the contents of line num (i) from filename
			#which is the question
			question=$(sed -n "${i}p" $filename)
			echo $question
			#userinput - their answer to the question
			read useranswer
			#the line number for the answer, which is i+1
			answerLine=$((i+1))
			#this variable now contains the contents of line num(answerLine) from filename
			answer=$(sed -n "${answerLine}p" $filename)
			#check to see if the user answer is the same as the answer in the textfile
			if [[ $useranswer == $answer ]]
			then
				echo "That is correct"
				#increment their score
				score=$((score+1))
			else
				echo "Sorry. That is incorrect"
				#output the right answer
				echo "The correct answer was: "$answer
			fi
		done
		echo "Well done. You have finished."
		echo "Your score was "$score" out of "$numofquestions
	else
		echo "ERROR. The file must be a text file"
		echo "In the text file the question goes on the odd lines"
		echo "The answer goes on the even lines"
	fi
fi
exit
