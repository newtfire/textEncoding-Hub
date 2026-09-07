# SSH Key Setup for GitHub or Codeberg

These instructions walk you through generating an SSH key, connecting it to your Git host of choice (GitHub **or** Codeberg — the process is identical until the last step), and setting your identity in `.gitconfig` so your commits are properly attributed.

You'll need a terminal:
- **Mac/Linux:** the built-in Terminal app
- **Windows:** Git Bash (installed with [Git for Windows](https://git-scm.com/download/win)) 
(**Note for Windows people**: Do NOT use Command Prompt or PowerShell for these steps, and unless you have PowerShell specially configured for git and Linux commands, stick with Git Bash for git related things, )

---

## 1. Check for an existing SSH key

Before generating a new key, check if you already have one:

```bash
ls -al ~/.ssh
```

Look for a pair of files like `id_ed25519` and `id_ed25519.pub` (or `id_rsa` / `id_rsa.pub`). If you see one, you can skip to Step 3 — or generate a fresh one anyway if you want a key dedicated to this class.

---

## 2. Generate a new SSH key

Run this command, replacing the email with the one tied to your GitHub or Codeberg account:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

- **Ed25519, not RSA:** newer, faster, shorter, and supported by both GitHub and Codeberg. If a tutorial you find online tells you to use `-t rsa -b 4096`, that still works but isn't necessary.
- When asked **"Enter a file in which to save the key,"** press **Enter** to accept the default location.
- When asked for a **passphrase**, it's fine to press Enter twice for no passphrase for class purposes — or set one if you'd like the extra security (you'll just need to enter it each time you use the key, unless you add it to the agent below).

This creates two files: a **private key** (`id_ed25519`) that never leaves your machine, and a **public key** (`id_ed25519.pub`) that you'll upload to GitHub/Codeberg.

---

## 3. Start the SSH agent and add your key

The SSH agent remembers your key (and passphrase, if you set one) so you're not prompted every time.

**Mac/Linux/Git Bash on Windows** (same command for all three):

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

**Mac only, extra step:** if you're on macOS Sierra (10.12.2) or later, also create/edit `~/.ssh/config` so the key loads automatically and the passphrase is stored in your Keychain:

```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

Then run:

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

---

## 4. Copy your public key

You need the contents of the `.pub` file — never the private key — to paste into your account settings.

**Mac:**
```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

**Windows (Git Bash):**
```bash
clip < ~/.ssh/id_ed25519.pub
```

**Linux:**
```bash
cat ~/.ssh/id_ed25519.pub
```
(then select and copy the output manually, or install `xclip` and use `xclip -sel clip < ~/.ssh/id_ed25519.pub`)

---

## 5. Add the key to your account — pick your host

### If you're using GitHub
1. Go to **Settings → SSH and GPG keys → New SSH key**
2. Give it a title (e.g. "class laptop"), paste your public key, and save.
3. Test the connection:
   ```bash
   ssh -T git@github.com
   ```
   You should see a message confirming you've authenticated.

### If you're using Codeberg
1. Go to **Settings → SSH/GPG Keys → Add Key**
2. Give it a title, paste your public key, and save.
3. Test the connection:
   ```bash
   ssh -T git@codeberg.org
   ```
4. **First-time connection note:** you'll likely be asked to verify the host's authenticity ("The authenticity of host 'codeberg.org' can't be established..."). This is normal and is SSH protecting you from impersonation — compare the fingerprint shown against [Codeberg's published fingerprints](https://docs.codeberg.org/security/ssh-fingerprint/) before typing `yes`. This is a good moment to actually explain to the class *why* this prompt exists rather than just clicking through it.

---

## 6. Set your Git identity (`.gitconfig`)

This is separate from your SSH key — it controls the name and email attached to your commits, and applies no matter which host you push to. In your shell (Git Bash on Windows, or Terminal on Mac), work through these steps in order:

**1. Check your current config:**

```bash
git config --list
```

Carefully read the output and look for the `user.name` and `user.email` fields. Do these match your GitHub or Codeberg username and the email address you used to set up that account?

- **If so, all is well!** Take a screenshot of your shell showing the `user.name` and `user.email` fields and submit that for this assignment.
- **If not,** correct them with the next two commands.

**2. Correct your username** — enter your own GitHub or Codeberg username in place of the placeholder text:

```bash
git config --global user.name "yourUserName"
```

**3. Correct your email** — enter the email address tied to your GitHub or Codeberg account in place of the placeholder text:

```bash
git config --global user.email "yourEmailForGitHubOrCodeberg"
```

**4. Run `git config --list` again** and inspect the output. Once `user.name` and `user.email` are correct, take the screenshot and submit it with this assignment.

A couple of other settings worth setting once, up front, while you're in here:

```bash
git config --global init.defaultBranch main
git config --global core.editor "nano"
```

NOTE: We're using `nano` as the default editor so you stay in the shell rather than popping out to a GUI editor. This keeps commit messages in Bash, which is the habit we want for this class. (If you're curious: VSCodium *can* be set as `git`'s editor with `git config --global core.editor "codium --wait"`, but that's not what we're using here.)

For more on `git config`, see [Graphite's guide to configuring your Git repository](https://graphite.dev/guides/how-to-configure-your-git-repository-with-the-git-config-command).

---

## Quick recap

| Step | Command |
|---|---|
| Generate key | `ssh-keygen -t ed25519 -C "you@example.com"` |
| Start agent | `eval "$(ssh-agent -s)"` |
| Add key to agent | `ssh-add ~/.ssh/id_ed25519` |
| Copy public key | `pbcopy` / `clip` / `cat` (OS-dependent) |
| Test connection | `ssh -T git@github.com` or `ssh -T git@codeberg.org` |
| Check identity | `git config --list` |
| Set identity | `git config --global user.name/email` |