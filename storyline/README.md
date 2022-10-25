# Storyline

Someone from your company, Foobar, was paid $10,000 to share the root password to your GitLab server.

Taking the role of the attacker, see how you can disrupt Detroit's traffic system whilst listening to some tracks by local artists.

## Company

The CTF is based around the taxi company __Foobar__. They are an industry leading taxi company who are targeted by many actors due to the size and profile of the company. Actors look to disrupt their services to weaken their profile within the market, gain access to credentials to pivot within the system, credentials for denial of wallet attacks, and also for bragging rights

## Recon

Here are the credentials to start with:

- website: <http://gitlab.foobar.com>
- username: `root`
- password: `Ikn0wwh@ty0ud1dl@5tKub3C0n3`

### Email Chain

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

My username is root for some reason, so you can use that on gitlab.foobar.com.

Password is Ikn0wwh@ty0ud1dl@5tKub3C0n3 (Case sensitive!)

Thanks for the track day!

---

```
