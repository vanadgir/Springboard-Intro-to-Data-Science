> library(readr)

> titanic_original <- read_csv("~/Springboard/Foundations of Data Science/R projects/titanic_original.csv")
Parsed with column specification:
cols(
  pclass = col_integer(),
  survived = col_integer(),
  name = col_character(),
  sex = col_character(),
  age = col_double(),
  sibsp = col_integer(),
  parch = col_integer(),
  ticket = col_character(),
  fare = col_double(),
  cabin = col_character(),
  embarked = col_character(),
  boat = col_character(),
  body = col_integer(),
  home.dest = col_character()
)

> View(titanic_original)

> titanic_df <- tbl_df(titanic_original)

> embarked_df <- titanic_df %>% filter(embarked %in% c("S", "Q", "C"))
> embarked_na_df <- titanic_df %>% filter(!embarked %in% c("S", "Q", "C")) %>% mutate(embarked = "S")

> titanic_df <- bind_rows(embarked_df, embarked_na_df)

> mean(titanic_df$age, na.rm = TRUE)
[1] 29.88113

> titanic_df %>% filter(is.na(age))
# A tibble: 263 x 14
   pclass survived                                                        name    sex   age sibsp
    <int>    <int>                                                       <chr>  <chr> <dbl> <int>
 1      1        0                                         Baumann, Mr. John D   male    NA     0
 2      1        1           "Bradley, Mr. George (\"George Arthur Brayton\")"   male    NA     0
 3      1        0                                   Brewe, Dr. Arthur Jackson   male    NA     0
 4      1        0                                       Cairns, Mr. Alexander   male    NA     0
 5      1        1 Cassebeer, Mrs. Henry Arthur Jr (Eleanor Genevieve Fosdick) female    NA     0
 6      1        1                      Chibnall, Mrs. (Edith Martha Bowerman) female    NA     0
 7      1        0                       Chisholm, Mr. Roderick Robert Crispin   male    NA     0
 8      1        0                                 Clifford, Mr. George Quincy   male    NA     0
 9      1        0                                   Crafton, Mr. John Bertram   male    NA     0
10      1        0                                          Farthing, Mr. John   male    NA     0
# ... with 253 more rows, and 8 more variables: parch <int>, ticket <chr>, fare <dbl>, cabin <chr>,
#   embarked <chr>, boat <chr>, body <int>, home.dest <chr>

> titanic_df %>% filter(!is.na(age))
# A tibble: 1,046 x 14
   pclass survived                                            name    sex     age sibsp parch
    <int>    <int>                                           <chr>  <chr>   <dbl> <int> <int>
 1      1        1                   Allen, Miss. Elisabeth Walton female 29.0000     0     0
 2      1        1                  Allison, Master. Hudson Trevor   male  0.9167     1     2
 3      1        0                    Allison, Miss. Helen Loraine female  2.0000     1     2
 4      1        0            Allison, Mr. Hudson Joshua Creighton   male 30.0000     1     2
 5      1        0 Allison, Mrs. Hudson J C (Bessie Waldo Daniels) female 25.0000     1     2
 6      1        1                             Anderson, Mr. Harry   male 48.0000     0     0
 7      1        1               Andrews, Miss. Kornelia Theodosia female 63.0000     1     0
 8      1        0                          Andrews, Mr. Thomas Jr   male 39.0000     0     0
 9      1        1   Appleton, Mrs. Edward Dale (Charlotte Lamson) female 53.0000     2     0
10      1        0                         Artagaveytia, Mr. Ramon   male 71.0000     0     0
# ... with 1,036 more rows, and 7 more variables: ticket <chr>, fare <dbl>, cabin <chr>,
#   embarked <chr>, boat <chr>, body <int>, home.dest <chr>

> age_df <- titanic_df %>% filter(!is.na(age))
> age_na_df <- titanic_df %>% filter(is.na(age)) %>% mutate(age = mean(titanic_df$age, na.rm = TRUE))

> View(age_na_df)
> titanic_df <- bind_rows(age_df, age_na_df)

> View(titanic_df)
> distinct(titanic_df, boat)
# A tibble: 28 x 1
    boat
   <chr>
 1     2
 2    11
 3  <NA>
 4     3
 5    10
 6     D
 7     4
 8     9
 9     6
10     B
# ... with 18 more rows

> titanic_df %>% filter(is.na(boat))
# A tibble: 823 x 14
   pclass survived                                            name    sex   age sibsp parch   ticket
    <int>    <int>                                           <chr>  <chr> <dbl> <int> <int>    <chr>
 1      1        0                    Allison, Miss. Helen Loraine female     2     1     2   113781
 2      1        0            Allison, Mr. Hudson Joshua Creighton   male    30     1     2   113781
 3      1        0 Allison, Mrs. Hudson J C (Bessie Waldo Daniels) female    25     1     2   113781
 4      1        0                          Andrews, Mr. Thomas Jr   male    39     0     0   112050
 5      1        0                         Artagaveytia, Mr. Ramon   male    71     0     0 PC 17609
 6      1        0                          Astor, Col. John Jacob   male    47     1     0 PC 17757
 7      1        0                        Baxter, Mr. Quigg Edmond   male    24     0     1 PC 17558
 8      1        0                             Birnbaum, Mr. Jakob   male    25     0     0    13905
 9      1        0                    Blackwell, Mr. Stephen Weart   male    45     0     0   113784
10      1        0                        Borebank, Mr. John James   male    42     0     0   110489
# ... with 813 more rows, and 6 more variables: fare <dbl>, cabin <chr>, embarked <chr>, boat <chr>,
#   body <int>, home.dest <chr>

> boat_df <- titanic_df %>% filter(!is.na(boat))
> boat_na_df <- titanic_df %>% filter(is.na(boat))

> View(boat_na_df)

> boat_na_df <- titanic_df %>% filter(is.na(boat)) %>% mutate(boat = "None")
> View(boat_na_df)

> titanic_df <- bind_rows(boat_df, boat_na_df)
> View(titanic_df)


> titanic_df <- mutate(titanic_df, has_cabin_number = ifelse(is.na(cabin), 0, 1))
> View(titanic_df)

> View(titanic_df %>% select(survived, has_cabin_number))
> titanic_df %>% filter(survived == 0, has_cabin_number == 0)
# A tibble: 707 x 15
   pclass survived                                                name    sex      age sibsp parch
    <int>    <int>                                               <chr>  <chr>    <dbl> <int> <int>
 1      2        0                             Renouf, Mr. Peter Henry   male 34.00000     1     0
 2      3        0                          Backstrom, Mr. Karl Alfred   male 32.00000     1     0
 3      3        0                  Harmer, Mr. Abraham (David Lishin)   male 25.00000     0     0
 4      3        0                       Lindell, Mr. Edvard Bengtsson   male 36.00000     1     0
 5      3        0 Lindell, Mrs. Edvard Bengtsson (Elin Gerda Persson) female 30.00000     1     0
 6      3        0                                 Yasbeck, Mr. Antoni   male 27.00000     1     0
 7      1        0                            Hoyt, Mr. William Fisher   male 29.88113     0     0
 8      3        0                                   Keefe, Mr. Arthur   male 29.88113     0     0
 9      1        0                             Artagaveytia, Mr. Ramon   male 71.00000     0     0
10      1        0                                 Birnbaum, Mr. Jakob   male 25.00000     0     0
# ... with 697 more rows, and 8 more variables: ticket <chr>, fare <dbl>, cabin <chr>,
#   embarked <chr>, boat <chr>, body <int>, home.dest <chr>, has_cabin_number <dbl>
> titanic_df %>% filter(survived == 0, has_cabin_number == 1)
# A tibble: 102 x 15
   pclass survived                                            name    sex   age sibsp parch   ticket
    <int>    <int>                                           <chr>  <chr> <dbl> <int> <int>    <chr>
 1      1        0                            Beattie, Mr. Thomson   male    36     0     0    13050
 2      1        0                    Allison, Miss. Helen Loraine female     2     1     2   113781
 3      1        0            Allison, Mr. Hudson Joshua Creighton   male    30     1     2   113781
 4      1        0 Allison, Mrs. Hudson J C (Bessie Waldo Daniels) female    25     1     2   113781
 5      1        0                          Andrews, Mr. Thomas Jr   male    39     0     0   112050
 6      1        0                          Astor, Col. John Jacob   male    47     1     0 PC 17757
 7      1        0                        Baxter, Mr. Quigg Edmond   male    24     0     1 PC 17558
 8      1        0                    Blackwell, Mr. Stephen Weart   male    45     0     0   113784
 9      1        0                        Borebank, Mr. John James   male    42     0     0   110489
10      1        0                         Brady, Mr. John Bertram   male    41     0     0   113054
# ... with 92 more rows, and 7 more variables: fare <dbl>, cabin <chr>, embarked <chr>, boat <chr>,
#   body <int>, home.dest <chr>, has_cabin_number <dbl>
> titanic_df %>% filter(survived == 1, has_cabin_number == 0)
# A tibble: 307 x 15
   pclass survived                                             name    sex   age sibsp parch   ticket
    <int>    <int>                                            <chr>  <chr> <dbl> <int> <int>    <chr>
 1      1        1                 "Barber, Miss. Ellen \"Nellie\"" female    26     0     0    19877
 2      1        1                            Bidois, Miss. Rosalie female    42     0     0 PC 17757
 3      1        1                         Bowen, Miss. Grace Scott female    45     0     0 PC 17608
 4      1        1 Candee, Mrs. Edward (Helen Churchill Hungerford) female    53     0     0 PC 17606
 5      1        1                             Cleaver, Miss. Alice female    22     0     0   113781
 6      1        1                      Daniel, Mr. Robert Williams   male    27     0     0   113804
 7      1        1                             Daniels, Miss. Sarah female    33     0     0   113781
 8      1        1                    Frauenthal, Dr. Henry William   male    50     2     0 PC 17611
 9      1        1                   Gibson, Miss. Dorothy Winifred female    22     0     1   112378
10      1        1          Gibson, Mrs. Leonard (Pauline C Boeson) female    45     0     1   112378
# ... with 297 more rows, and 7 more variables: fare <dbl>, cabin <chr>, embarked <chr>, boat <chr>,
#   body <int>, home.dest <chr>, has_cabin_number <dbl>
> titanic_df %>% filter(survived == 0, has_cabin_number == 1)
# A tibble: 102 x 15
   pclass survived                                            name    sex   age sibsp parch   ticket
    <int>    <int>                                           <chr>  <chr> <dbl> <int> <int>    <chr>
 1      1        0                            Beattie, Mr. Thomson   male    36     0     0    13050
 2      1        0                    Allison, Miss. Helen Loraine female     2     1     2   113781
 3      1        0            Allison, Mr. Hudson Joshua Creighton   male    30     1     2   113781
 4      1        0 Allison, Mrs. Hudson J C (Bessie Waldo Daniels) female    25     1     2   113781
 5      1        0                          Andrews, Mr. Thomas Jr   male    39     0     0   112050
 6      1        0                          Astor, Col. John Jacob   male    47     1     0 PC 17757
 7      1        0                        Baxter, Mr. Quigg Edmond   male    24     0     1 PC 17558
 8      1        0                    Blackwell, Mr. Stephen Weart   male    45     0     0   113784
 9      1        0                        Borebank, Mr. John James   male    42     0     0   110489
10      1        0                         Brady, Mr. John Bertram   male    41     0     0   113054
# ... with 92 more rows, and 7 more variables: fare <dbl>, cabin <chr>, embarked <chr>, boat <chr>,
#   body <int>, home.dest <chr>, has_cabin_number <dbl>
> titanic_df %>% filter(survived == 1, has_cabin_number == 1)
# A tibble: 193 x 15
   pclass survived                                              name    sex     age sibsp parch
    <int>    <int>                                             <chr>  <chr>   <dbl> <int> <int>
 1      1        1                     Allen, Miss. Elisabeth Walton female 29.0000     0     0
 2      1        1                    Allison, Master. Hudson Trevor   male  0.9167     1     2
 3      1        1                               Anderson, Mr. Harry   male 48.0000     0     0
 4      1        1                 Andrews, Miss. Kornelia Theodosia female 63.0000     1     0
 5      1        1     Appleton, Mrs. Edward Dale (Charlotte Lamson) female 53.0000     2     0
 6      1        1 Astor, Mrs. John Jacob (Madeleine Talmadge Force) female 18.0000     1     0
 7      1        1                     Aubart, Mme. Leontine Pauline female 24.0000     0     0
 8      1        1              Barkworth, Mr. Algernon Henry Wilson   male 80.0000     0     0
 9      1        1   Baxter, Mrs. James (Helene DeLaudeniere Chaput) female 50.0000     0     1
10      1        1                             Bazzani, Miss. Albina female 32.0000     0     0
# ... with 183 more rows, and 8 more variables: ticket <chr>, fare <dbl>, cabin <chr>,
#   embarked <chr>, boat <chr>, body <int>, home.dest <chr>, has_cabin_number <dbl>

> write.csv(titanic_df, "titanic_clean.csv")
