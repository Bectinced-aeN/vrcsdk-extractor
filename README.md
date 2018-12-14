# Vrcsdk-extractor

This is a utility to extract the vrcsdk packages to an easier to manage format, namely extracting the `.unitypackage`:s via https://github.com/gered/extractunitypackage and the `dll` files inside with https://github.com/icsharpcode/ILSpy/tree/master/ICSharpCode.Decompiler.Console

## Usage

1. Install [.NET Core SDK](https://dotnet.microsoft.com/download) (dotnet) & [git](https://git-scm.com/downloads)
2. clone the project somewhere
3. Add any sdk unitypackages you want to extract in the project folder
4. run `./decompile.sh` inside the project folder

when its done the files will be in the `output` folder
note. all embedded .dll files will be extracted into {filename}-dll folders and the original dll files will be deleted.
