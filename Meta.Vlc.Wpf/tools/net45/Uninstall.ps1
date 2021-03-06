param($installPath, $toolsPath, $package, $project)

$allowedReferences = @("Meta.Vlc.Wpf, Version=18.12.31.0, Culture=neutral, processorArchitecture=x86")

# Full assembly name is required
Add-Type -AssemblyName 'Microsoft.Build, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'

$projectCollection = [Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection

$allProjects = $projectCollection.GetLoadedProjects($project.Object.Project.FullName).GetEnumerator();

if($allProjects.MoveNext())
{
    foreach($Reference in $allProjects.Current.GetItems('Reference') | ? {$allowedReferences -contains $_.UnevaluatedInclude })
    {
        $allProjects.Current.RemoveItem($Reference)
    }
}