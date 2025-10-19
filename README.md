# Introduction to Model Checking with Spin

(under construction)

I used to give a semester-long course on model checking. For now, I pull out **three short introductions** to model checking that can be read independently and present the topic from different angles.

- Lecture 1: For a hands-on introduction to the workings of Spin I present how Spin can be used for solving the [Wolf, Goat, Cabbage](notes/Wolf-Goat-Cabbage.md) puzzle.

- Lecture 2: For a highlevel introduction, I like [Model Checking: A Tutorial Overview](https://members.loria.fr/SMerz/papers/mc-tutorial.pdf) by Stephan Merz. I will write a short meta-tutorial with exercises and code in [Model Checking the Needham-Schroeder Protocol](notes/Needham-Schroeder.md).

- Lecture 3: For a more indepth analysis of a classic example of concurrency theory, see [Mutual-Exclusion.md](notes/Mutual-Exclusion.md).

I also have an [introduction to the introductions](./notes/Introduction.md) which gives a short technical summary of LTL in Spin.

The official webpages of [Spin](https://spinroot.com/spin/whatispin.html) have much information of general interest (highly recommended).

To follow the exercises, you need to install Spin. Last time, I didnt have to follow the [installation instructions](https://spinroot.com/spin/Man/README.html), I just run (on macos): 
```
brew install spin
```

