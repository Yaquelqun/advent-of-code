# AdventOfCode
Welcome, welcome to my solution repo for the riddles of advent of codes

The goal of the entire project is to try out a more Object Oriented way of coding and try - by adding heavy constraints to the way I usually code - to come up with a more elegant/efficient way of programming.

# Rules
- All riddles should be solved inside of the application
- I should only have to launch one line and then interact with the application (as if i ran a rails s)
- Rubocop TO THE MAX (i set up rubocop and changed NOTHING)
- Try to be [SOLID](https://www.digitalocean.com/community/conceptual_articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design) as much as my understanding of the SOLID principle allows me to be.
- Follow Sandi Metz [5 rules for OOP](https://yiming.dev/blog/2017/08/23/sandi-metzs-rules-for-oop/) or at least the ones that are applicable to a pure Ruby application

# Architecture
## Github
  I'll try to have one branch per year. I usually don't have the motivationt to solve all puzzles but hey who knows maybe one day ^^
## Code
I'll try to keep the master branch as a template so that as the years go by, i can checkout from master and start with a new architecture.
### Architecture
 It's a simple Ruby project for now with minimal gem usage.
 To launch the project, you have to launch `ruby run.rb` to run the `run.rb` file.
 The code is organized this way: 
  - All the input files are in the inputs directory
  - There is one input parser that you can call to parse the inputs
  - The idea is to create one solver per day and include it in the SolversDictionnary class (require and in the Hash). This should make the new solver available from the console interface
  - Each day usually has one abstraction level that i usually put in the model folder
  - Inter day abstraction levels (if there are any) can go in helpers
  - The rest of the code is in the solver class (maybe i could have a folder per day if i want to have several files for each day)