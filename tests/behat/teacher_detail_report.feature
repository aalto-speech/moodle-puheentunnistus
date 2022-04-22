@mod @mod_digitala @javascript
Feature: Teacher can see students detailed report

  Background:
    Given the following "users" exist:
      | username | firstname | lastname   | email                     |
      | ossi     | Ossi      | Opettaja   | ossi.opettaja@koulu.fi    |
      | olli     | Olli      | Opiskelija | olli.opiskelija@koulu.fi  |
      | essi     | Essi      | Opiskelija | essi.opiskelija@koulu.fi  |
      | seppo    | Seppo     | Opiskelija | seppo.opiskelija@koulu.fi |
      | milla    | Milla     | Opiskelija | milla.opiskelja@koulu.fi  |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user  | course | role    |
      | ossi  | C1     | manager |
      | olli  | C1     | student |
      | essi  | C1     | student |
      | seppo | C1     | student |
      | milla | C1     | student |
    And the following "activities" exist:
      | activity | name      | intro                | course | idnumber  | attemptlang | attempttype | assignment                 | resources                                  | resourcesformat | attemptlimit |
      | digitala | Freeform  | This is a freeform.  | C1     | freeform  | sv          | freeform    | Berätta om Tigerjakt.      | Här är filmen om tiger.                    | 1               | 0            |
      | digitala | Readaloud | This is a readaloud. | C1     | readaloud | fi          | readaloud   | Lue seuraava lause ääneen. | Tämä on liikennevalojen perusteet -kurssi. | 1               | 2            |
    And I add freeform attempt to database:
      | name     | username | attemptnumber | file  | transcript  | fluency | taskcompletion | pronunciation | lexicogrammatical | holistic | recordinglength | status    |
      | Freeform | olli     | 1             | file1 | transcript1 | 1       | 1              | 2             | 3                 | 1        | 1               | evaluated |
      | Freeform | essi     | 1             | file2 | transcript2 | 0       | 0              | 0             | 0                 | 0        | 5               | waiting   |
      | Freeform | seppo    | 1             | file3 | transcript3 | 0       | 0              | 0             | 0                 | 0        | 4               | retry     |
      | Freeform | milla    | 1             | file4 | transcript4 | 0       | 0              | 0             | 0                 | 0        | 3               | failed    |
    And I add readaloud attempt to database:
      | name      | username | attemptnumber | file  | transcript  | feedback | fluency | pronunciation | recordinglength | status    |
      | Readaloud | olli     | 1             | file5 | transcript5 | feedback | 2.2     | 1.4           | 6               | evaluated |
      | Readaloud | essi     | 1             | file6 | transcript6 | feedback | 0       | 0             | 7               | waiting   |
      | Readaloud | seppo    | 1             | file7 | transcript7 | feedback | 0       | 0             | 8               | retry     |
      | Readaloud | milla    | 1             | file8 | transcript8 | feedback | 0       | 0             | 9               | failed    |

  Scenario: Detailed report does not show for student in freeform
    When I am on the "Freeform > olli" "mod_digitala > Teacher Report Details" page logged in as "olli"
    And I should see "Access denied"

  Scenario: Detailed report does not show for student in readaloud
    When I am on the "Readaloud > olli" "mod_digitala > Teacher Report Details" page logged in as "olli"
    And I should see "Access denied"

  Scenario: Detailed report shows correctly for freeform
    When I am on the "Freeform > olli" "mod_digitala > Teacher Report Details" page logged in as "ossi"
    And I should see "Assignment"
    And I should see "Language: Swedish"
    And I should see "Type: Freeform"
    And I should see "Berätta om Tigerjakt."
    And I click on "Material" "button"
    And I should see "Material"
    And I should see "Här är filmen om tiger."
    And I should see "There is no limit set for the number of attempts on this assignment."
    And I should see "A transcript of your speech sample"
    And I should see "transcript1"
    And I should see "Task completion"
    And I should see "1/3"
    And I should see "This measure is based on the previous responses that have been used in teaching the machine to grade this task. Based on the automatic grading, it seems that you only partially responded to the assignment."
    And I should see "Fluency"
    And I should see "1/4"
    And I should see "This measure reflects the speed, pauses, and hesitations in your speech. Based on the automatic grading, it seems that your speech has many pauses, breaks, or hesitations."
    And I should see "Pronunciation"
    And I should see "2/4"
    And I should see "Above you can see that the machine transformed your speech into text. There you can check whether you pronounced all the words right. This measure reflects how well the machine understands your speech. The speech samples that the machine has heard before affect its ability to understand you. Based on the automatic grading, it seems that"
    And I should see "the machine understands your speech quite well, but there might be some pronunciation problems in the speech sample."
    And I should see "Range"
    And I should see "3/3"
    And I should see "This measure reflects how much you have spoken and how comprehensive your vocabulary and sentence structures are. Based on the automatic grading, it seems that you have comprehensive vocabulary and use a variety of sentence structures."
    Then I click on "Proficiency level" "button"
    And I should see "Proficiency level"
    And I should see "A1"
    And I should see "You are able to produce some sentences in the target language (for example, greet somebody or tell about yourself)."

  Scenario: Detailed report shows correctly for readaloud
    When I am on the "Readaloud > olli" "mod_digitala > Teacher Report Details" page logged in as "ossi"
    And I should see "Assignment"
    And I should see "Language: Finnish"
    And I should see "Type: Read aloud"
    And I should see "Lue seuraava lause ääneen."
    And I click on "Material" "button"
    And I should see "Material"
    And I should see "Tämä on liikennevalojen perusteet -kurssi."
    And I should see "Number of attempts remaining: 1"
    And I should see "A transcript of your speech sample"
    And I should see "transcript5"
    And I should see "Fluency"
    And I should see "2/4"
    And I should see "This measure reflects the speed, pauses, and hesitations in your speech. Based on the automatic grading, it seems that"
    And I should see "your speech is fairly fluent, but some pauses, breaks, and hesitations occur."
    And I should see "Pronunciation"
    And I should see "1/4"
    And I should see "Above you can see that the machine transformed your speech into text. There you can check whether you pronounced all the words right. This measure reflects how well the machine understands your speech. The speech samples that the machine has heard before affect its ability to understand you. Based on the automatic grading, it seems that"
    And I should see "the machine struggles to understand you."

  Scenario: After sending to evaluation, waiting prompt is shown in freeform
    When I am on the "Freeform > essi" "mod_digitala > Teacher Report Details" page logged in as "ossi"
    And I should see "Assignment"
    And I should see "Language: Swedish"
    And I should see "Type: Freeform"
    And I should see "Berätta om Tigerjakt."
    And I click on "Material" "button"
    And I should see "Material"
    And I should see "Här är filmen om tiger."
    And I should see "Evaluation in progress"
    And I should see "Evaluation is in progress, please hold. This could take up to few eternities."
    And I should see "Press here to check if evaluation is completed."

  Scenario: After sending to evaluation, waiting prompt is shown in readaloud
    When I am on the "Readaloud > essi" "mod_digitala > Teacher Report Details" page logged in as "ossi"
    And I should see "Assignment"
    And I should see "Language: Finnish"
    And I should see "Type: Read aloud"
    And I should see "Lue seuraava lause ääneen."
    And I click on "Material" "button"
    And I should see "Material"
    And I should see "Tämä on liikennevalojen perusteet -kurssi."
    And I should see "Evaluation in progress"
    And I should see "Evaluation is in progress, please hold. This could take up to few eternities."
    And I should see "Press here to check if evaluation is completed."

  Scenario: If evaluation failed, retry prompt is shown in freeform
    When I am on the "Freeform > seppo" "mod_digitala > Teacher Report Details" page logged in as "ossi"
    And I should see "Assignment"
    And I should see "Language: Swedish"
    And I should see "Type: Freeform"
    And I should see "Berätta om Tigerjakt."
    And I click on "Material" "button"
    And I should see "Material"
    And I should see "Här är filmen om tiger."
    And I should see "Evaluation failed"
    And I should see "Automated evaluation failed. Evaluation will be runned again in a hour. This could take up to few eternities."

  Scenario: If evaluation failed, retry prompt is shown in readaloud
    When I am on the "Readaloud > seppo" "mod_digitala > Teacher Report Details" page logged in as "ossi"
    And I should see "Assignment"
    And I should see "Language: Finnish"
    And I should see "Type: Read aloud"
    And I should see "Lue seuraava lause ääneen."
    And I click on "Material" "button"
    And I should see "Material"
    And I should see "Tämä on liikennevalojen perusteet -kurssi."
    And I should see "Evaluation failed"
    And I should see "Automated evaluation failed. Evaluation will be runned again in a hour. This could take up to few eternities."

  Scenario: Detailed report shows correctly for freeform if failed to evaluate
    When I am on the "Freeform > milla" "mod_digitala > Teacher Report Details" page logged in as "ossi"
    And I should see "Assignment"
    And I should see "Language: Swedish"
    And I should see "Type: Freeform"
    And I should see "Berätta om Tigerjakt."
    And I click on "Material" "button"
    And I should see "Material"
    And I should see "Här är filmen om tiger."
    And I should see "There is no limit set for the number of attempts on this assignment."
    And I should see "There is no limit set for the number of attempts on this assignment."
    And I should see "A transcript of your speech sample"
    And I should see "transcript4"
    And I should see "Task completion"
    And I should see "0/3"
    And I should see "This measure is based on the previous responses that have been used in teaching the machine to grade this task. Based on the automatic grading, it seems that"
    And I should see "unfortunately, the machine has not heard this type of performance before and therefore failed to grade your speech. However, do not be discouraged: try again!"
    And I should see "Fluency"
    And I should see "0/4"
    And I should see "This measure reflects the speed, pauses, and hesitations in your speech. Based on the automatic grading, it seems that"
    And I should see "unfortunately, the machine has not heard this type of performance before and therefore failed to grade your speech. However, do not be discouraged: try again!"
    And I should see "Pronunciation"
    And I should see "0/4"
    And I should see "Above you can see that the machine transformed your speech into text. There you can check whether you pronounced all the words right. This measure reflects how well the machine understands your speech. The speech samples that the machine has heard before affect its ability to understand you. Based on the automatic grading, it seems that"
    And I should see "unfortunately, the machine has not heard this type of performance before and therefore failed to grade your speech. However, do not be discouraged: try again!"
    And I should see "Range"
    And I should see "0/3"
    And I should see "This measure reflects how much you have spoken and how comprehensive your vocabulary and sentence structures are. Based on the automatic grading, it seems that"
    And I should see "unfortunately, the machine has not heard this type of performance before and therefore failed to grade your speech. However, do not be discouraged: try again!"
    Then I click on "Proficiency level" "button"
    And I should see "Proficiency level"
    And I should see "Below A1"
    And I should see "Based on the automatic grading, it seems that your proficiency level is"
    And I should see "You are able to produce some words in the target language."

  Scenario: Detailed report shows correctly for readaloud if failed to evaluate
    When I am on the "Readaloud > milla" "mod_digitala > Teacher Report Details" page logged in as "ossi"
    And I should see "Assignment"
    And I should see "Language: Finnish"
    And I should see "Type: Read aloud"
    And I should see "Lue seuraava lause ääneen."
    And I click on "Material" "button"
    And I should see "Material"
    And I should see "Tämä on liikennevalojen perusteet -kurssi."
    And I should see "Number of attempts remaining: 1"
    And I should see "A transcript of your speech sample"
    And I should see "transcript8"
    And I should see "Fluency"
    And I should see "0/4"
    And I should see "This measure reflects the speed, pauses, and hesitations in your speech."
    And I should see "Based on the automatic grading, it seems that unfortunately, the machine has not heard this type of performance before and therefore failed to grade your speech. However, do not be discouraged: try again!"
    And I should see "Pronunciation"
    And I should see "0/4"
    And I should see "Above you can see that the machine transformed your speech into text. There you can check whether you pronounced all the words right. This measure reflects how well the machine understands your speech. The speech samples that the machine has heard before affect its ability to understand you. Based on the automatic grading, it seems that"
    And I should see "unfortunately, the machine has not heard this type of performance before and therefore failed to grade your speech. However, do not be discouraged: try again!"
