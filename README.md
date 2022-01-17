#Enigma
This encryption program was built based on the requirements of the [Enigma](https://backend.turing.edu/module1/projects/enigma/index) project from [Turing School of Software and Design](https://turing.edu/).
It was submitted by Mark Ertmer (2111 BE) in January 2022 as the Final Project for Mod 1.

###Table of Contents
* [About](#about-this-application)
* [Getting Started](#getting-started)
* [Encrypting Messages](#encrypting-messages)
* [Decrypting Messages](#decrypting-messages)
* [Cracking Encrypted Messages](#cracking-encrypted-messages)
* [Encryption Algorithm](#encryption-algorithm)
* [Input Handling](#input-handling)
* [Exploration: Finding Equivalent Keys](#exploration)

##About this Application
This application uses an algorithm to encrypt and decrypt a text-based message with the use of a 5-digit, randomly-generated `key` and the 6-digit numeric `date` of encryption in DDMMYY format. The application is run from the command line, where the user can designate an input file to encrypt/decrypt and an output file to write the resulting encryption/decryption.

##Getting Started
1. Fork and Clone this repo to your machine.
2. In your terminal, navigate to the home directory, titled `enigma`.

###Encrypting Messages
The command to encrypt a text file follows this structure:
```
ruby encrypt.rb <source file> <output file>
```
...where the `<source file>` is the filepath to the text you wish to encrypt. The program then writes the encrypted text to the `<output file>` specified.
####EXAMPLE:
1. You will see there is a `test_message.txt` in the `file` directory. It contains the text:
   ```
    Hello, this is a test! Have a super day. end
```
2. Run this command from your terminal:
   ```
   ruby encrypt.rb ./file/test_message.txt ./file/test_encryption.txt
```
3. The `test_encryption.txt` output is created in the `file` directory with encrypted text that might look something like this:
   ```
   inmiuu,hqqo xryhyizmpb!fpydkhyiybmnxhajd.hbwj
```
4. A confirmation message prints to the terminal, giving the output filepath, along with the `key` and `date`. These two pieces of information will be needed to decrypt the message later.
   ```
   Created ./file/test_encryption.txt with the key 32547 and date 170122
```

###Decrypting Messages
The command to encrypt a text file follows this structure:
```
ruby decrypt.rb <source file> <output file> <key> <date>
```
As with `encrypt`, the `decrypt` command takes a source and output file, but also requires the `key` and `date` that were used for the encryption.
####EXAMPLE:
1. To decrypt the message that was encrypted above, enter this command:
   ```
   ruby decrypt.rb ./file/test_encryption.txt ./file/test_decipheration.txt 32547 170122
```
   Notice that the `key` and `date` were taken from the previous example.
2. `test_decipheration.txt` is created in `file`, and contains the decoded text:
   ```
    hello, this is a test! have a super day. end
   ```
3. A confirmation prints to the terminal, giving the output filepath, along with the `key` and `date` used:
   ```
   Created ./file/test_decipheration.txt with the key 32547 and date 170122
   ```

###Cracking Encrypted Messages
It is possible that an intercepted message could be decoded without a key, provided the following assumptions are correct:
* The date of encryption is known.
* The message ends in " end".

####EXAMPLE:
1. To crack the encrypted message from above, enter this command:
   ```
   ruby crack.rb ./file/test_encryption.txt ./file/test_crack.txt 170122
   ```
   You'll need to include the source and output files, along with the six-digit `date` believed to be used for encryption.
2. `test_crack.txt` is created in `file`, and contains the decoded text:
   ```
    hello, this is a test! have a super day. end
   ```
3. A confirmation prints to the terminal, giving the output filepath, along with the `date` used and cracked `key`.
   ```
   Created ./file/test_crack.txt with the cracked key 32547 and date 170122
   ```

##Encryption Algorithm
1. The algorithm makes use of a 27-character set which includes all the lowercase letters in the English alphabet plus a space. The program stores this information as an array to allow easy access to each character and its index:
   ```@characters = ("a".."z").to_a << " "
```
2. The algorithm shifts each character __n__ number of places through the array. For example, an "a" shifted 3 places becomes a "d". It rolls back from the end of the array, so "z" with a shift of 2 becomes "a" (remember the set ends with a space).
3. As the program moves through the message string, different shifts are applied. There is an `A` shift, a `B` shift, a `C` shift, and a `D` shift, which are rotated sequentially (the first character uses the A shift, the second is B, etc.).
  * The `A` shift key comes from the __first two numbers__ in the key. (__57__034 -> 57)
  * The `B` shift key comes from the __second and third__ numbers in the key. (5__70__34 -> 70)
  * The `C` shift key comes from the __third and fourth__ numbers in the key. (57__03__4 -> 03)
  * The `D` shift key comes from the __fourth and fifth__ numbers in the key. (578__34__ -> 34)
4. In addition, an _offset_ is applied to each shift key that comes from the six digit date:
  * Square the date: 170122 * 170122 = 28941494884
  * Retain the last four digits: 4884
    * The first digit is the `A` offset: 4
    * The second digit is the `B` offset: 8
    * The third digit is the `C` offset: 8
    * The fourth digit is the `D` offset: 4
5. The total shift is the sum of the _shift key_ and _offset_ for each letter:
  * `A` shift = 57 + 4 = 61
  * `B` shift = 70 + 8 = 78
  * `C` shift = 03 + 8 = 11
  * `D` shift = 34 + 4 = 38

Note: Uppercase letters are automatically downcased before encryption, so any decrypted message will not include capitalization.

Note: If the message text includes any symbols that are not included in the character set, such as numbers or punctuation, those symbols are essentially ignored and passed to the output encryption (or decryption, as the case may be) unchanged.

##Input Handling
To avoid crashing, the program includes contingencies for the following improper input scenarios when running `encrypt.rb`, `decrypt.rb`, and `crack.rb`:
* invalid or missing source file and path
* invalid filepath or missing directory for output file
* wrong number of arguments
* invalid key syntax
* invalid date syntax

If any of these conditions apply, the program ends after outputting a message to help the user enter a valid command:
```
INVALID INPUT
- Make sure your source file is valid.
- Make sure to use a valid filepath for your output.
- The key must be exactly 5 digits, numbers only.
- Enter a date using 'DDMMYY' formatting. 6 digits, numbers only.
COMMAND STRUCTURE:
$ ruby decrypt.rb <source filepath> <output filepath> <key> <date>
```

##Exploration
###Finding Equivalent Keys
While testing my `crack` methods, there were several isolated times when a reliable method failed. The reason was that the `key` found did not match the key used for the original encryption, although it was able to accurately decrypt the message.

I realized that it is possible for more than one key to result in the same effective `A`, `B`, `C`, and `D` shifts, because numbers larger than 27 loop back around. So in other words, a shift of 30 is equivalent to a shift of 3 (because 30 = 27 + 3), or a shift of 71 is equivalent to a shift of 17 (because 71 = 27 + 27 + 17).  

I was curious to see how many such sets of equivalent keys existed in all the possible keys, so I wrote a short script to find out:
```ruby
all_keys = ("00000".."99999").to_a
shifts = {}

all_keys.each do |key|
  shift_keys = {A: key[0..1].to_i, B: key[1..2].to_i, C: key[2..3].to_i, D: key[3..4].to_i}
  shift_keys.each do |letter, shiftkey|
    until shiftkey < 27 do
      shiftkey -= 27
    end
    shift_keys[letter] = shiftkey
  end
  shifts[shift_keys] ||= []
  shifts[shift_keys] << key
end
```
###RESULTS
* There are 14,760 __pairs of keys__ that can decrypt the same message.
* There are 1,022 __sets of three__ keys that can decrypt the same message.
* There is __one set of __four keys__ that can decrypt the same message. They are:
  * 09090
  * 90909
  * 36363
  * 63636

  (Each of these keys results in an `A`, `B`, `C`, and `D` shift of 9)

###IMPLICATIONS FOR PROBABILITY
On its face, the chance of guessing a correct 5-digit key appears to be one in 100,000 (all the numbers from 00000 to 99999). However, the chances are somewhat better than that:

* There are 14,760 cases where guessing a key would result in being equivalent to __one__ other: subtract 14,760
* There are 1,022 cases where guessing a key would result in being equivalent to __two__ other keys: subtract 2,044 (1,022 * 2)
* There is 1 case where guessing a key would result in being equivalent to __three__ other keys: subtract 3

* 100,000 - 14,760 - 2,044 - 3 = 83,193

Accounting for this, the chance of guessing a correct key for a given encryption becomes one in 83,193.
