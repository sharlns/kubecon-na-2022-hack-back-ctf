# Attendee

## Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

## Introduction

Someone from your company, __Foobar__, was paid $10,000 to share the root password to your GitLab server.

Taking the role of the attacker, see how you can disrupt Detroit's traffic system whilst listening to some tracks by local artists.

## Company

The CTF is based around the taxi company __Foobar__. They are an industry leading taxi company who are targeted by many actors due to the size and profile of the company. Actors look to disrupt their services to weaken their profile within the market, gain access to credentials to pivot within the system, credentials for denial of wallet attacks, and also for bragging rights

## Recon

### Credentials

Here are the credentials to start with:

- website: <http://gitlab.foobar.com>
- username: `root`
- password: `Ikn0wwh@ty0ud1dl@5tKub3C0n3`

#### Email Chain

```txt

---

from:     ******@protonmail.com
to:       ******@gmail.com
subject:  Paid track day

Hey! We've seen from your recent likes on social media that you like cars.

We wondered if you'd like to go to a track day event and we're pretty sure you'd come first and win our $10,000 prize for the best parallel parking competition (cash or bitcoin).

All this for a username and password, are you game?

---

from: ******@gmail.com
to:   ******@protonmail.com
subject:  Re: Paid track day

My username is root for some reason, so you can use that on GitLab.foobar.com.

Password is Ikn0wwh@ty0ud1dl@5tKub3C0n3 (Case sensitive!)

Thanks for the track day!

---

```

## Applications

### The Homer

![Homer Simpson in The Homer](./the-homer.gif)

_The Homer_ is the trademark taxi for __Foobar__, offering a best in class from A to B.

#### The Homer - Press Release

__Foobar__ Taxi's are proud to announce that they will only transport you in _The Homer_!

#### The Homer - Information

We monitor our drivers and passengers via our __Ride Based Automotive Control (RBAC)__ to allow you to get your homer.

#### The Homer - Updates

__Foobar__ Taxi's are pleased to announce that passengers can now update their rides thanks to our update __Ride Based Automotive Control (RBAC)__ policies, why not give it a try and pivot into your next ride!

### Beep Beep

![Traffic lights](./beepbeep.gif)

__Foobar__ want to give back to the community, and have developed a system to eliminate traffic congestion in Detroit with the latest AI.

#### Beep Beep - Press Release

__Foobar__ are excited to announce at the speed of Traffic Light, a system built in memory!

#### Beep Beep - Information

In the event of a crash, we output the all the application details into the log as there is no memory.

#### Beep Beep - Updates

Unexpected costs of running BeepBeep in the cloud have caused us to scale back our workforce considerably. __Foobar__ have been said to be amazed at the unexpected bill as their application is not set to scale.

### Boombox

![Boombox](./boombox.jpeg)

__Foobar__ now allows you to control the music, but why stop there? We also offer lyrics thanks to our new service!

#### Boombox - Information

Due to feedback, we've reduced the size of the boombox by reducing the dependency weight. The content has been baked into the boombox so no need to bring your own vinyl, tapes, CD, or minidisks.

#### Boombox - Updates

This month, we're focusing on the early 00's straight out of Detroit!
