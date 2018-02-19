##Read in the training files for the assignment.
trainingData<-read.table("X_train.txt", header=F)
trainingSubjects<-read.table("subject_train.txt", header=F)
trainingActivites<-read.table("y_train.txt", header=F)

##Read in the test files for the assignment.
testData<-read.table("X_test.txt", header=F)
testSubjects<-read.table("subject_test.txt", header=F)
testActivites<-read.table("y_test.txt", header=F)

##Read in the features file to get the variable names
features<-read.table("features.txt", header=F, stringsAsFactors = F)

## Subset features for only mean and std variables
MeanFeatures<-features[grep("mean", features[,2], ignore.case=F, 
                         value=F, fixed = T)]
StdFeatures<-features[grep("std", features[,2], ignore.case=F, 
                  value =F, fixed=T),]
MeanAndStdFeatures<-rbind(MeanFeatures, StdFeatures)


##Replace activity numbers with descriptions for eac of traning and test
trainingActivites[,1]<-as.character(trainingActivites[,1])
trainingActivites[,1]<-factor(trainingActivites[,1], c("1","2","3","4","5","6"),
                              c("walking", "walkingupstairs", "walkingdownstairs"
                                , "sitting", "standing", "laying"))
testActivites[,1]<-as.character(testActivites[,1])
testActivites[,1]<-factor(testActivites[,1], c("1","2","3","4","5","6"),
                              c("walking", "walkingupstairs", "walkingdownstairs"
                                , "sitting", "standing", "laying"))

##Bind together relevant files from training and test
Activities<-rbind(trainingActivites, testActivites)
Subjects<-rbind(trainingSubjects, testSubjects)
AllData<-rbind(trainingData, testData)

## Name Activities and Subjects Columns
colnames(Activities) <- c("Activities")
colnames(Subjects) <- c("Subjects")

##Take only the columns of AllData with mean and std
x<-c(MeanAndStdFeatures[,1])
RefinedData<-AllData[,x]


##Name variables in RefindedData
MeanAndStdFeatures[,2]<-as.character(MeanAndStdFeatures[,2])
y <-c(MeanAndStdFeatures[,2])
colnames(RefinedData) <-c(y)

##Add Actvities and Subjects to Data
DescData<-cbind(Subjects, Activities, RefinedData)

##Make variable names tidier (get rid of dash, () and uppercase letters)
names(DescData) <- gsub("-", "", names(DescData), ignore.case = F, 
                         fixed = F, perl = F)
names(DescData) <- gsub("\\()", "", names(DescData), ignore.case = F, 
                        fixed = F, perl = F)
names(DescData) <- tolower(names(DescData))

##Save new data set (final answer to parts 1-4 of assignment)
write.table(DescData, "./DescData.txt")

##create a second, independent tidy data set with the average of 
##each variable for each activity and each subject (part 5 of assignment)

##initialize two empty vectors
vect<-c()
vec<-c()

## a for loop to subset the data for each of the 30 subjects
for (i in 1:30){
    df<-filter(DescData, Subjects==i)
    
    ## a for loop to subset the data for each of the 79 variables
    for (j in 1:79){
        
        ## Each letter is the mean for a subject, a variable, 
        ## and the marked activity.
        A<-mean(df[df$activities=="walking",j+2])
        B<-mean(df[df$activities=="walkingupstairs", j+2])
        C<-mean(df[df$activities=="walkingdownstairs", j+2])
        D<-mean(df[df$activities=="sitting", j+2])
        E<-mean(df[df$activities=="standing", j+2])
        G<-mean(df[df$activities=="laying", j+2])
        vec<-c(vec, A, B,C, D, E, G)
    }
    vect<-c(vect,vec)
}

## Add labels to each row of data and the column of means

##Initialize two empty vectors
w<-c()
v<-c()

## For loops to get names of each subject, activity, and variable
for (i in 1:30){
    for (j in 1:79){
        a<-paste(i,"walking",colnames(DescData[j+2]))
        v<-c(v,a)
    }
    w<-c(w, v)
}

##Bind together the names and data
tidy<-cbind(w, vect)

##Name the columns per tidy data set rules
z<-c("", "averages")
colnames(tidy)<-c(z)

##Save resulting file (part 5 of assignment)
write.table(tidy, file = "./tidy.txt")
