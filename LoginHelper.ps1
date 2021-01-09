# Credit goes to https://universecitiz3n.tech/selenium/Selenium-Powershell/ for setup 
# https://powershellone.wordpress.com/2015/02/12/waiting-for-elements-presence-with-selenium-web-driver/ 

# Webdriver.Support.dll can be downloaded from https://github.com/AdyKalra/WAF-WebAutomationFramework/blob/master/WAF/Packages/Selenium.Support/3.4.0/lib/net40/WebDriver.Support.dll


# Load Selenium DLL files 
$PathToFolder = "$pwd\"
[System.Reflection.Assembly]::LoadFrom("{0}\WebDriver.dll" -f $PathToFolder);
[System.Reflection.Assembly]::LoadFrom("{0}\WebDriver.Support.dll" -f $PathToFolder);
if ($env:Path -notcontains ";$PathToFolder" ) {
    $env:Path += ";$PathToFolder"
}

# Configure Chrome Browser
$ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
$ChromeOptions.AddArgument('start-maximized')
$ChromeOptions.AcceptInsecureCertificates = $True


# Navigate to VCU zoom site but don't login
$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeOptions)
$ChromeDriver.Url = ''
$username = $ChromeDriver.FindElementById("username"); 
$password = $ChromeDriver.FindElementById("password"); 
$username.SendKeys($env:USERNAME);
