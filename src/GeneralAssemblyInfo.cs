#region U S A G E S

using System.Reflection;
using System.Resources;

#endregion

#if DEBUG
[assembly: AssemblyConfiguration("Debug")]
#else
[assembly: AssemblyConfiguration("Release")]
#endif

[assembly: AssemblyCompany("RzR Core ®")]
[assembly: AssemblyProduct("")]
[assembly: AssemblyCopyright("Copyright © 2024 RzR All rights reserved.")]
[assembly: AssemblyTrademark("®™")]
[assembly: AssemblyCulture("")]

[assembly: AssemblyMetadata("TermsOfService", "")]

[assembly: AssemblyMetadata("ContactUrl", "")]
[assembly: AssemblyMetadata("ContactName", "RzR SRL")]
[assembly: AssemblyMetadata("ContactEmail", "")]

[assembly: NeutralResourcesLanguage("en-US", UltimateResourceFallbackLocation.MainAssembly)]

//
//  Major version - manually modified
//  Current year
//  Current month
//  Increment build number
//
[assembly: AssemblyVersion("1.25.3.4")]
[assembly: AssemblyFileVersion("1.25.3.4")]
[assembly: AssemblyInformationalVersion("1.25.3.4")]
