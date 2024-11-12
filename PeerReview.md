# Code Review for Programming Exercise 1 #
## Description ##

For this assignment, you will be giving feedback on the completeness of Exercise 1.  To do so, we will be giving you a rubric to provide feedback on. For the feedback, please provide positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to review the code and project files that were given out by the instructor.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.

## Due Date and Submission Information ##
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer-review. The file name should be the same as in the template: PeerReview-Exercise1.md. You also need to include your name and email address in the Peer-reviewer Information section below. This review document should be placed into the base folder of the repo you are reviewing in the master branch. This branch should be on the origin of the repository you are reviewing.

If you are in the rare situation where there are two peer-reviewers on a single repository, append your UC Davis user name before the extension of your review file. An example: PeerReview-Exercise1-username.md. Both reviewers should submit their reviews in the master branch.  

## Solution Assessment ##

## Peer-reviewer Information

* *name:* Quinn Broderick 
* *email:* qjbroderick@ucdavis.edu

### Description ###

To assess the solution, you will be choosing ONE choice from unsatisfactory, satisfactory, good, great, or perfect. Place an x character inside of the square braces next to the appropriate label.

The following are the criteria by which you should assess your peer's solution of the exercise's stages.

#### Perfect #### 
    Cannot find any flaws concerning the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    A major flaw and some minor flaws.

#### Satisfactory ####
    A couple of major flaws. Heading towards a solution, however, did not fully realize the solution.

#### Unsatisfactory ####
    Partial work, but not really converging to a solution. Pervasive major flaws. Objective largely unmet.


### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Allows for all player movement is functional, the player is always at center of screen for the camera, 5x5 unit cross is drawn when draw_camera_logic (F is pressed) is true.

### Stage 2 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Player movement is allowed in all directions and the box is drawn when draw_camera_logic (F is pressed) is true. The box does move horizontally at a constant speed, player is kept within confines of the box and is pushed forward if they lag behind. (Only issue would be that the top and bottom of box are not visible in the camera view and the player is allowed to move off the screen *within box confines* in z-direction).

### Stage 3 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Player movement is allowed in all directions, camera follows player at a slower speed, camera catches up to player when player stops moving. 5x5 unit cross is drawn when draw_camera_logic (F is pressed) is true. (Only issue is player leash distance doesn't seem to exist, player is allowed to move seemingly endless distance from camera center).

### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [X] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Camera leads player in direction of input, camera approaches player when player stops moving. 5x5 unit cross is drawn when draw_camera_logic (F is pressed) is true. (Only issue is player leash distance doesn't seem to exist, player is allowed to move seemingly endless distance from camera center). 

### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [X] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
When player is in inner box, camera doesn't move, when it's in the space inbetween the outer and inner box (not touching edges of outer box) camera moves at push_ratio with player. Issues with player touching edges of either box. If touching inner box edges then moves again inside inner box, player position is oriented off the edge. Not allowed to touch the edges of the outer box (but does move appropriately *ie moves as though it is touching the edge*). Issues with corner of outer box, can't move player into corner of the box in any way. 

## Code Style ##

### Description ###
Check the scripts to see if the student code follows the .Net style guide.

If sections don't adhere to the style guide, please permalink the line of code from GitHub and justify why the line of code has infractions of the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Here is an example of the permalink drop-down on GitHub.

![Permalink option](../images/permalink_example.png)

Here is another example as well.

* [I go to Github and look at the ICommand script in the ECS189L repo!](https://github.com/dr-jam/ECS189L/blob/1618376092e85ffd63d3af9d9dcc1f2078df2170/Projects/CommandPatternExample/Assets/Scripts/ICommand.cs#L5)

### Code Style Review ###

#### Style Guide Infractions ####
I really couldn't find any issues with code style, great job!  

#### Style Guide Exemplars ####
Everything was formatted correctly, all variables were declared in the proper positioning, functions were organized properly, basic comments made interpretation easy w/o overloading program with in-line comments. 

* [all function formatting universal, I.E. indentations, spacing, etc.](https://github.com/ensemble-ai/exercise-2-camera-control-ethereal-chxn/blob/dda45e9830e730ad7a24b74d9f62be622b04e16e/Obscura/scripts/camera_controllers/position_lock_lerp_camera.gd#L15)

* [consistency with all the draw_logic functions makes them more comprehensive](https://github.com/ensemble-ai/exercise-2-camera-control-ethereal-chxn/blob/dda45e9830e730ad7a24b74d9f62be622b04e16e/Obscura/scripts/camera_controllers/position_lock_lerp_camera.gd#L36)

* [universal organization/correct organization of class name and export/public variables](https://github.com/ensemble-ai/exercise-2-camera-control-ethereal-chxn/blob/dda45e9830e730ad7a24b74d9f62be622b04e16e/Obscura/scripts/camera_controllers/four_way_speedup_push_zone_camera.gd#L1)

## Best Practices ## 


### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document), then feel free to point at these segments of code as examples. 

If the student has breached the best practices and has done something that should be noted, please add the infracture.

This should be similar to the Code Style justification.

* [description of infraction](https://github.com/dr-jam/ECS189L) [and here](https://github.com/ensemble-ai/exercise-1-command-pattern-ScorpionXiao/blob/7ba5f917e9c27184af8bdf3ddc54ca0aa14c8f7d/Rut/scripts/follower.gd#L8)

### Best Practices Review ###

#### Best Practices Infractions ####

Occasional interesting spacing choices inbetween lines but otherwise all variables/classses named appropriately using correct naming practices for each. Functions are written in a chronological order that makes sense and are easy to follow, comments were also useful for understanding sections of the code. 

#### Best Practices Exemplars ####
* [odd spacing around a line like this:](https://github.com/ensemble-ai/exercise-2-camera-control-ethereal-chxn/blob/dda45e9830e730ad7a24b74d9f62be622b04e16e/Obscura/scripts/camera_controllers/position_lock_camera.gd#L5)

* [good exmaple of proper variable naming and organization](https://github.com/ensemble-ai/exercise-2-camera-control-ethereal-chxn/blob/dda45e9830e730ad7a24b74d9f62be622b04e16e/Obscura/scripts/camera_controllers/four_way_speedup_push_zone_camera.gd#L5)

* [comprehensive and succint comments](https://github.com/ensemble-ai/exercise-2-camera-control-ethereal-chxn/blob/dda45e9830e730ad7a24b74d9f62be622b04e16e/Obscura/scripts/camera_controllers/framebound_autoscroll_camera.gd#L25)