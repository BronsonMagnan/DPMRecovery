##########################
# Bronson Magnan, 2018.
##########################

Import-Module DataProtectionManager

####################################################################################################
#region Load XAML code
[xml]$XAML = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DPM File Recovery" Height="460" Width="950">
    <Grid Margin="0,0,2,-2" Height="425" VerticalAlignment="Top">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="807*"/>
            <ColumnDefinition Width="71*"/>
        </Grid.ColumnDefinitions>
        
        <Label Name="labelDpmServerName"    Content="DPM Server Name"    HorizontalAlignment="Left" Margin="10,10,0,0"  VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="labelAltRestoreServer" Content="Alt Restore Server" HorizontalAlignment="Left" Margin="10,41,0,0"  VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="labelAltRestoreVolume" Content="Alt Restore Volume" HorizontalAlignment="Left" Margin="10,72,0,0"  VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="labelAltRestorePath"   Content="Alt Restore Path"   HorizontalAlignment="Left" Margin="10,103,0,0" VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="labelProtectionGroups" Content="Protection Groups"  HorizontalAlignment="Left" Margin="10,154,0,0" VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="labelDatasources"      Content="Data Sources"       HorizontalAlignment="Left" Margin="10,185,0,0" VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="labelRecoveryPoints"   Content="Recovery Points"    HorizontalAlignment="Left" Margin="10,216,0,0" VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="labelSearchDirectory"  Content="Search Directory"   HorizontalAlignment="Left" Margin="10,247,0,0" VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="labelSearchTerm"       Content="Search Term"        HorizontalAlignment="Left" Margin="10,278,0,0" VerticalAlignment="Top" Width="113" Height="26"/>
        <Label Name="label5"         Content="Search could take a while" HorizontalAlignment="Left" Margin="10,353,0,0" VerticalAlignment="Top" Width="147" Height="26"/>

        <TextBox  Name="textBoxDPMServerName"     HorizontalAlignment="Left" Margin="126,10,0,0"  VerticalAlignment="Top" Width="178" Height="26"  TextWrapping="NoWrap"   ToolTip="DPM Server FQDN"/>
        <ComboBox Name="comboBoxAltRestoreServer" HorizontalAlignment="Left" Margin="126,41,0,0"  VerticalAlignment="Top" Width="178" Height="26"/>
        <ComboBox Name="comboBoxAltRestoreVolume" HorizontalAlignment="Left" Margin="126,72,0,0"  VerticalAlignment="Top" Width="178" Height="26"/>
        <TextBox  Name="textBoxAltRestorePath"    HorizontalAlignment="Left" Margin="126,103,0,0" VerticalAlignment="Top" Width="178" Height="26"  TextWrapping="NoWrap" />
        <ComboBox Name="comboBoxProtectionGroups" HorizontalAlignment="Left" Margin="126,154,0,0" VerticalAlignment="Top" Width="178" Height="26"/>
        <ComboBox Name="comboBoxDataSources"      HorizontalAlignment="Left" Margin="126,185,0,0" VerticalAlignment="Top" Width="178" Height="26"/>
        <ComboBox Name="comboBoxRecoveryPoints"   HorizontalAlignment="Left" Margin="126,216,0,0" VerticalAlignment="Top" Width="178" Height="26"/>
        <TextBox  Name="textBoxSearchDirectory"   HorizontalAlignment="Left" Margin="126,247,0,0" VerticalAlignment="Top" Width="269" Height="26" TextWrapping="NoWrap"  />
        <TextBox  Name="textBoxSearchTerm"        HorizontalAlignment="Left" Margin="126,278,0,0" VerticalAlignment="Top" Width="178" Height="26"  TextWrapping="NoWrap"   ToolTip="Search Term"/>

        <Button Name="buttonAltRestoreServerRefresh" Content="R" HorizontalAlignment="Left" Margin="309,41,0,0"  VerticalAlignment="Top" Width="26" Height="26"/>
        <Button Name="buttonAltRestoreVolumeRefresh" Content="R" HorizontalAlignment="Left" Margin="309,72,0,0"  VerticalAlignment="Top" Width="26" Height="26"/>
        <Button Name="buttonProtectionGroupRefresh"  Content="R" HorizontalAlignment="Left" Margin="309,154,0,0" VerticalAlignment="Top" Width="26" Height="26"/>
        <Button Name="buttonDataSourceRefresh"       Content="R" HorizontalAlignment="Left" Margin="309,185,0,0" VerticalAlignment="Top" Width="26" Height="26"/>
        <Button Name="buttonRecoveryPointRefresh"    Content="R" HorizontalAlignment="Left" Margin="309,216,0,0" VerticalAlignment="Top" Width="26" Height="26"/>

        <Button Name="buttonConnectToDPMServer"      Content="Connect" HorizontalAlignment="Left" Margin="340,10,0,0"  VerticalAlignment="Top" Width="75" Height="26"/>
        <Button Name="buttonAltRestoreServerSelect"  Content="Select" HorizontalAlignment="Left"  Margin="340,41,0,0"  VerticalAlignment="Top" Width="75" Height="26"/>
        <Button Name="buttonAltRestoreVolumeSelect"  Content="Select" HorizontalAlignment="Left"  Margin="340,72,0,0"  VerticalAlignment="Top" Width="75" Height="26"/>
        <Button Name="buttonProtectionGroupSelect"   Content="Select" HorizontalAlignment="Left"  Margin="340,154,0,0" VerticalAlignment="Top" Width="75" Height="26"/>
        <Button Name="buttonDataSourceSelect"        Content="Select" HorizontalAlignment="Left"  Margin="340,185,0,0" VerticalAlignment="Top" Width="75" Height="26"/>
        <Button Name="buttonRecoveryPointSelect"     Content="Select" HorizontalAlignment="Left"  Margin="340,216,0,0" VerticalAlignment="Top" Width="75" Height="26"/>


        <Button Name="buttonExecuteSearch" Content="Search" HorizontalAlignment="Left" Margin="340,358,0,0" VerticalAlignment="Top" Width="75" Height="26"/>

        <Label Name="label4" Content="Search Results" HorizontalAlignment="Left" Margin="430,10,0,0" VerticalAlignment="Top" Width="92" Height="26"/>



        
        <StackPanel Name="StackPanelSearchType" HorizontalAlignment="Left" Height="61" Margin="340,279,0,0" VerticalAlignment="Top" Width="93">
            <RadioButton Name="radioButtonContains"   Content="Contains" GroupName="SearchType" IsChecked="True"/>
            <RadioButton Name="radioButtonStartsWith" Content="Starts With" GroupName="SearchType"/>
            <RadioButton Name="radioButtonEndsWith"   Content="Ends With" GroupName="SearchType"/>
            <RadioButton Name="radioButtonExactMatch" Content="Exact Match" GroupName="SearchType"/>
        </StackPanel>

        <ListView Name="lvSearchResults" HorizontalAlignment="Left" Margin="430,46,0,0" VerticalAlignment="Top" Height="287" Width="425" BorderBrush="SlateBlue" BorderThickness="1" >
                
            <ListView.Resources>
                <Style TargetType="{x:Type GridViewColumnHeader}">
                    <Setter Property="HorizontalContentAlignment" Value="Left" />
                </Style>
            </ListView.Resources>
            <ListView.View>
                <GridView>
                    <GridViewColumn Header="File Name"         Width="125" DisplayMemberBinding="{Binding FileName}" />
                    <GridViewColumn Header="Changed Date Time" Width="125" DisplayMemberBinding="{Binding ChangedDateTime}" />
                    <GridViewColumn Header="Size (bytes)"      Width= "75" DisplayMemberBinding="{Binding Size}" />
                    <GridViewColumn Header="Logical Path"      Width="200" DisplayMemberBinding="{Binding LogicalPath}" />
                </GridView>
            </ListView.View>  
        </ListView>

        <Label Name="labelRecoveryJobStatus" Content="Recovery Job Status" HorizontalAlignment="Left" Margin="430,353,0,0" VerticalAlignment="Top" Width="150" Height="26"/>
        <TextBox Name="textBoxRecoveryJobStatus" HorizontalAlignment="Left" Margin="430,379,0,0" VerticalAlignment="Top" Width="250" Height="26" TextWrapping="NoWrap" BorderBrush="SlateBlue" BorderThickness="1"/>

        <Button Name="buttonExecuteRestore" Content="Restore" HorizontalAlignment="Left" Margin="780,358,0,0" VerticalAlignment="Top" Width="75" Height="26"/>
        <Button Name="buttonExit" Content="Exit" HorizontalAlignment="Left" Margin="780,387,0,0" VerticalAlignment="Top" Width="75" Height="26"/>

    </Grid>
</Window>
"@
#Get-Content .\MainWindow6.xaml
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')

$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try {
    $Form=[Windows.Markup.XamlReader]::Load( $reader )
} catch{
     throw "Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered.";
}

$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}
#endregion XAML code
####################################################################################################

####################################################################################################
#region CustomerHints class
class CustomerHints {
    [String]$DPMServerName
    [String]$DefaultRestoreServer
    [String]$DefaultRestoreVolume
    [string]$DefaultRestorePath
    hidden [string]$configfile = ".\CustomerHints.json"
    CustomerHints ($DpmServerName,$DefaultRestoreServer,$DefaultRestoreVolume,$DefaultRestorePath) {
        $this.DpmServerName = $DpmServerName; $this.DefaultRestoreServer = $DefaultRestoreServer; $this.DefaultRestoreVolume = $DefaultRestoreVolume; $this.DefaultRestorePath = $DefaultRestorePath;
    }
    CustomerHints () { 
        #LoadFromFileConstructor
        $testPath = test-path -path $this.configfile
        if ($testPath) {
            $temp = Get-Content -Path $this.configfile | ConvertFrom-Json
            $this.DpmServerName = $temp.DpmServerName; $this.DefaultRestoreServer = $temp.DefaultRestoreServer; $this.DefaultRestoreVolume = $temp.DefaultRestoreVolume; $this.DefaultRestorePath = $temp.DefaultRestorePath;
        } else {
            $this.DpmServerName = $null; $this.DefaultRestoreServer = $null; $this.DefaultRestoreVolume = $null; $this.DefaultRestorePath = $null;
        }
    }
    [void]SaveConfigFile () {
        $temp = @{
            "DPMServerName" = $this.DPMServerName;
            "DefaultRestoreServer" = $this.DefaultRestoreServer;
            "DefaultRestoreVolume" = $this.DefaultRestoreVolume;
            "DefaultRestorePath" = $this.DefaultRestorePath;
        }
        $temp | ConvertTo-Json -Depth 10 | Out-File -FilePath $this.configfile -Encoding ascii -Force
    }
    [string] getDpmServerName         () { return $this.DpmServerName        }
    [string] getDefaultRestoreServer  () { return $this.DefaultRestoreServer }
    [string] getDefaultRestoreVolume  () { return $this.DefaultRestoreVolume }
    [string] getDefaultRestorePath    () { return $this.DefaultRestorePath   }
    [void] setDpmServerName        ([string]$value) { $this.DpmServerName        = $value }
    [void] setDefaultRestoreServer ([string]$value) { $this.DefaultRestoreServer = $value }
    [void] setDefaultRestoreVolume ([string]$value) { $this.DefaultRestoreVolume = $value }
    [void] setDefaultRestorePath   ([string]$value) { $this.DefaultRestorePath   = $value }
}
#endregion
####################################################################################################

####################################################################################################
#region AltRestore Class

class AltRestore {
    $ServerList = @()
    $Server = $null
    $VolumeList = @()
    $Volume = $null
    $Path = $null
    [String]$FolderPath = ""
    [void]SelectServer($server) {
        $this.Server = $this.ServerList | where {$_.ServerName -eq $server}
    }
    [void]SelectVolume($volume) {
        $this.Volume = $this.VolumeList | where {$_.name -eq $volume }
    }
    [void]ResetServerList() {
        $this.ServerList = @()
    }
    [void]ReloadServerList($ComboBox) {
        $this.ResetServerList();
        if ($ComboBox.items) { 
            $ComboBox.items.clear()
        }
        $this.ServerList = Get-DPMProductionServer -DPMServerName $global:dpmServerName | Sort -Property ServerName
        foreach ($server in $this.ServerList.ServerName) { 
            $ComboBox.AddText($server) 
        } 
        $ComboBox.SelectedIndex = 0
    }
    [void]ResetVolumeList() {
        $this.VolumeList = @()
    }
    [void]ReloadVolumeList($ComboBox) {
        $this.ResetVolumeList();
        if ($ComboBox.items) { 
            $ComboBox.items.clear()
        }
        $this.VolumeList = Get-DPMDatasource -Inquire -ProductionServer $this.Server | where {$_.ObjectType -eq "Volume"} | sort -Property Name
        foreach($volume in $this.volumeList.name) {
        $comboBox.addText($volume)
        }
        $comboBox.SelectedIndex = 0
    }
    [void]ReloadFolderPath($textBox) {
        $this.FolderPath = $this.Volume.Name
        $textBox.text = $this.FolderPath
    }
    [void]SpecifyPreferredServer([string]$Server,$comboBox) {
        if (($this.ServerList).ServerName -contains $server) {
            $this.Server = $this.ServerList | where {$_.ServerName -eq $Server}
            $comboBox.text = ($this.ServerList| where {$_.ServerName -like $Server}).ServerName
        }
    }
    [void]SpecifyPreferredVolume([string]$Volume,$comboBox) {
        if ( ($this.VolumeList).name -contains $Volume) {
            $comboBox.text = ($this.VolumeList| where {$_.name -like $Volume }).name
            $this.volume = $this.VolumeList | where {$_.name -eq $Volume }
        }
    }
}

#endregion AltRestore Class
####################################################################################################

####################################################################################################
#region AltRestore Class UI Controls
$buttonAltRestoreServerRefresh.Add_Click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $AltRestore.ReloadServerList();
    $form.Cursor=$tempCursor
})

$buttonAltRestoreServerSelect.Add_Click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $AltRestore.SelectServer($comboBoxAltRestoreServer.Text)
    $Altrestore.ReloadVolumeList($comboBoxAltRestoreVolume);
    $AltRestore.ReloadFolderPath($textBoxAltRestorePath)
    $form.Cursor=$tempCursor
})

$buttonAltRestoreVolumeRefresh.Add_Click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $Altrestore.ReloadVolumeList($comboBoxAltRestoreVolume);
    $AltRestore.ReloadFolderPath($textBoxAltRestorePath)
    $form.Cursor=$tempCursor
})

$buttonAltRestoreVolumeSelect.Add_Click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $AltRestore.SelectVolume($comboBoxAltRestoreVolume.text)
    $AltRestore.ReloadFolderPath($textBoxAltRestorePath)
    $form.Cursor=$tempCursor
})

#endregion
####################################################################################################

####################################################################################################
#region BackupSelection Class
class BackupSelection {
    $ProtectionGroupList = @()
    $ProtectionGroup = $null
    $DataSourceList = @()
    $DataSource = $null
    $RecoveryPointList = @()
    $RecoveryPoint = $null
    [object]getRecoveryPoint() { return $this.RecoveryPoint }
    [object]getDataSource() { return $this.DataSource }
    [void]resetProtectionGroupList() { $this.ProtectionGroupList = @() }
    [void]resetDataSourceList() { $this.DataSourceList = @() }
    [void]resetRecoveryPointList() { $this.RecoveryPointList = @() }
    [void]reloadProtectionGroupList($comboBox) {
        $this.resetProtectionGroupList()
        if ($comboBox.items) { $comboBox.items.Clear() }
        $this.ProtectionGroupList = Get-DPMProtectionGroup -DPMServerName $global:dpmServerName | sort -Property Name
        foreach($PG in ($this.ProtectionGroupList).name) {
            $comboBox.AddText($PG) 
        }
        $comboBox.SelectedIndex = 0
    }
    [void]reloadDataSourceList($comboBox){
        $this.resetDataSourceList()
        if ($comboBox.items) { $comboBox.items.Clear() }
        $this.DataSourceList = Get-DPMDatasource -ProtectionGroup $this.ProtectionGroup | where {$_.ObjectType -eq "Volume"} | sort -Property Name
        foreach($DS in ($this.DataSourceList).name) {
            $comboBox.AddText($DS) 
        }
        $comboBox.SelectedIndex = 0
    }
    [void]reloadRecoveryPointList($comboBox){
        $this.resetRecoveryPointList()
        if ($comboBox.items) { $comboBox.items.Clear() }
        $this.RecoveryPointList = Get-DPMRecoveryPoint -Datasource $this.DataSource | Sort -Property RepresentedPointInTime -Descending
        foreach ($RP in ($this.RecoveryPointList).backuptime) { 
            $comboBox.AddText($RP) 
        }
        $comboBox.SelectedIndex = 0
    }
    [void]selectProtectionGroup([string]$value){
        $this.ProtectionGroup = $this.ProtectionGroupList | where {$_.name -eq $value }
    }
    [void]selectDataSource([string]$value){
        $this.DataSource= $this.DataSourceList | where {$_.name -eq $value }
    }
    [void]selectRecoveryPoint([string]$value){
        $this.RecoveryPoint = $this.RecoveryPointList | where {$_.backuptime -eq $value } 
    }
}

#endregion
####################################################################################################

####################################################################################################
#region BackupSelection Class UI Controls
function Clear-DataSourceComboBox() {
    $comboBoxDataSources.items.Clear()
    Clear-RecoveryPointComboBox;
}
function Clear-RecoveryPointComboBox() {
    $comboBoxRecoveryPoints.items.clear()
    Clear-SearchDirectoryTextBox;
}
function Clear-SearchDirectoryTextBox() {
    $textBoxSearchDirectory.clear()
}

function Set-SearchDirectoryTextBox($value) {
    $textBoxSearchDirectory.text = $value
}


$buttonProtectionGroupRefresh.Add_Click( { 
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $BackupSelection.reloadProtectionGroupList($comboBoxProtectionGroups)
    Clear-DataSourceComboBox;
    $form.Cursor=$tempCursor
})

$buttonProtectionGroupSelect.Add_CLick( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $BackupSelection.selectProtectionGroup($comboBoxProtectionGroups.text)
    $BackupSelection.reloadDataSourceList($comboBoxDataSources)
    $form.Cursor=$tempCursor
})

$buttonDataSourceRefresh.Add_Click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $BackupSelection.reloadDataSourceList($comboBoxDataSources)
    $BackupSelection.reloadRecoveryPointList($comboBoxRecoveryPoints)
    Set-SearchDirectoryTextBox($BackupSelection.DataSource.Name);
    $form.Cursor=$tempCursor
})

$buttonDataSourceSelect.add_click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $BackupSelection.selectDataSource($comboBoxDataSources.Text)
    Set-SearchDirectoryTextBox($BackupSelection.DataSource.Name);
    $BackupSelection.reloadRecoveryPointList($comboBoxRecoveryPoints)
    $BackupSelection.selectRecoveryPoint($comboBoxRecoveryPoints.text)
    $form.Cursor=$tempCursor
})

$buttonRecoveryPointRefresh.add_click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $BackupSelection.reloadRecoveryPointList($comboBoxRecoveryPoints)
    $BackupSelection.selectRecoveryPoint($comboBoxRecoveryPoints.text)
    $form.Cursor=$tempCursor
})

$buttonRecoveryPointSelect.add_click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $BackupSelection.selectRecoveryPoint($comboBoxRecoveryPoints.text)
    $form.Cursor=$tempCursor
})

#endregion
####################################################################################################

####################################################################################################
#region FileSearch Class
class RadioSearchType {
    [string]$searchType
    RadioSearchType($rbcontains,$rbstart,$rbend,$rbexact) {
        if ($rbcontains.isChecked) { $this.SearchType = "contains" }
        if ($rbstart.isChecked) { $this.SearchType = "startsWith" }
        if ($rbend.isChecked) { $this.SearchType = "endsWidth" }
        if ($rbexact.isChecked) { $this.SearchType = "exactMatch" }
    }
    [string]tostring() {
        return $this.SearchType
    }
}

class SearchProperties {
        [string]$SearchType;
        $RecoveryPoint;
        [string]$Location;
        [string]$SearchString;
        $SearchOptions;
        SearchProperties ($RecoveryPoint,[RadioSearchType]$SearchType,[string]$searchWhere,[string]$searchWhat) {
            $this.SearchType = $SearchType.tostring();
            $this.RecoveryPoint = $RecoveryPoint;
            $this.Location = $searchWhere;
            $this.SearchString = $searchWhat;
            switch ($this.SearchType) { 
                'contains' { $this.SearchOptions = New-DPMSearchOption -FromRecoveryPoint $RecoveryPoint.backupTime -ToRecoveryPoint $RecoveryPoint.backupTime -SearchDetail FilesFolders -SearchType contains -Recursive -Location $this.Location -SearchString $this.SearchString }
                'startsWith' { $this.SearchOptions = New-DPMSearchOption -FromRecoveryPoint $RecoveryPoint.backupTime -ToRecoveryPoint $RecoveryPoint.backupTime -SearchDetail FilesFolders -SearchType startsWith -Recursive -Location $this.Location -SearchString $this.SearchString }
                'endsWith' { $this.SearchOptions = New-DPMSearchOption -FromRecoveryPoint $RecoveryPoint.backupTime -ToRecoveryPoint $RecoveryPoint.backupTime -SearchDetail FilesFolders -SearchType endsWith -Recursive -Location $this.Location -SearchString $this.SearchString }
                'exactMatch' { $this.SearchOptions = New-DPMSearchOption -FromRecoveryPoint $RecoveryPoint.backupTime -ToRecoveryPoint $RecoveryPoint.backupTime -SearchDetail FilesFolders -SearchType exactMatch -Recursive -Location $this.Location -SearchString $this.SearchString }
            }
        }
        [object]getSearchOptions() {
            return $this.SearchOptions
        }
}

class SearchResults {
    $searchresults = @()
    SearchResults($datasource,$searchproperties) {
        $this.searchresults = Get-DPMRecoverableItem -Datasource $datasource -SearchOption $searchproperties
        $this.SortbyFileNameAscending()
    }
    [object[]]getSearchResults() {
        return $this.searchresults;
    }
    [void]Sort([string]$Property,[boolean]$Descending) {
        #unimplemented pattern
    }
    [Void]SortbyFileNameAscending() { $this.searchresults = $this.searchresults | Sort-Object -Property FileName }
    [Void]SortbyFileNameDescending() { $this.searchresults = $this.searchresults | Sort-Object -Property FileName -Descending }
}


#endregion
####################################################################################################

####################################################################################################
#region FileSearch Class UI Controls
$buttonExecuteSearch.add_click({
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    $SearchType = [RadioSearchType]::new($radioButtonContains,$radioButtonStartsWith,$radioButtonEndsWith,$radioButtonExactMatch)
    $SearchProperties = [SearchProperties]::new($BackupSelection.getRecoveryPoint(),$SearchType,$textBoxSearchDirectory.Text,$textBoxSearchTerm.text)
    $Global:SearchResults = [SearchResults]::new($BackupSelection.getDataSource(),$searchProperties.getSearchOptions())

    $form.Cursor = $tempCursor
    
    #Load the List View
    $lvSearchResults.ItemsSource = $Global:SearchResults.getSearchResults()
    
})
#endregion
####################################################################################################

####################################################################################################
#region FileRestore Class
#This class is generated when the execute file restore button is clicked
class FileRestore {
    $FilesToRestore=@();
    FileRestore([object[]] $InputRestoreObjects) {
        $this.FilesToRestore = $InputRestoreObjects
    }
    [int]getFileRestoreCount() {
        return $this.FilesToRestore.count;
    }
    [object[]]GetFilesToRestore() {
        return $this.FilesToRestore;
    }
    [void]WriteDebug() {
        $this.FilesToRestore | Select-Object -Property FileName | Write-Host
    }
}

#endregion
####################################################################################################

####################################################################################################
#region FileRestore Class UI Controls
$buttonExecuteRestore.add_click({
    #Create the restore class, and to hold the selected files.
    $RestoreFiles = [FileRestore]::new($lvSearchResults.SelectedItems)

    #Validate restore
    $msgBoxValidateRestore = [System.Windows.MessageBox]::Show("Confirm the restore of $($RestoreFiles.getFileRestoreCount()) files","Restore Confirmation",'OkCancel','Question')

    #execute the restore
    if ($msgBoxValidateRestore -eq "Ok") {

        #store the current cursor and change to the wait cursor
        $tempCursor = $form.Cursor
        $form.Cursor=[System.Windows.Input.Cursors]::Wait
        
        #execute the restore
        $RecoveryOption = New-DPMRecoveryOption -FileSystem -TargetServer $AltRestore.Server -RecoveryLocation CopyToFolder -OverwriteType NoOverwrite -RecoveryType Restore -AlternateLocation $AltRestore.FolderPath
        $Recoveryjob = Restore-DPMRecoverableItem -RecoverableItem $RestoreFiles.GetFilesToRestore() -RecoveryOption $RecoveryOption
        $CurrentStatus = $Recoveryjob.status
        $textBoxRecoveryJobStatus.Text = $CurrentStatus
        while ($CurrentStatus -ne "Succeeded") {
            Start-Sleep -Milliseconds 100
            $CurrentStatus = $Recoveryjob.status
            $textBoxRecoveryJobStatus.Text = $CurrentStatus
        }

        #reset the cursor
        $form.Cursor = $tempCursor

    }

})

#endregion
####################################################################################################


#region Global Variables and class instantiation
#Load Defaults
$Default = [CustomerHints]::new(); #Read in customer hints
$AltRestore = [AltRestore]::new()
$BackupSelection = [BackupSelection]::new()
$Global:SearchResults = $null;

if ($Default.DPMServerName) { $textBoxDPMServerName.text = $Default.getDpmServerName() } else {$textBoxDPMServerName.text = ""}

$global:dpmServerName = ""

$buttonExit.Add_Click({
   # Disconnect-DPMServer -DPMServerName $global:dpmServerName
    $Form.Close()
})
$textBoxRecoveryJobStatus.Text = "No Job Running"

#endregion globals



#################################################################################
#region DPM Connection
# DPM Server connection section

function connectDPMServer([string]$Server) {
    $global:dpmServerName = $server
    Connect-DPMServer -DPMServerName $($global:dpmServerName)
}
$buttonConnectToDPMServer.Add_Click( {
    $tempCursor = $form.Cursor
    $form.Cursor=[System.Windows.Input.Cursors]::Wait
    ConnectDPMServer($textBoxDPMServerName.Text);
    $BackupSelection.reloadProtectionGroupList($comboBoxProtectionGroups)
    $AltRestore.ReloadServerList($comboBoxAltRestoreServer)
    $AltRestore.SpecifyPreferredServer($Default.getDefaultRestoreServer(),$comboBoxAltRestoreServer)
    $AltRestore.ReloadVolumeList($comboBoxAltRestoreVolume)
    $AltRestore.SpecifyPreferredVolume($Default.getDefaultRestoreVolume(),$comboBoxAltRestoreVolume)
    $AltRestore.ReloadFolderPath($textBoxAltRestorePath)
    $form.Cursor = $tempCursor
})
#endregion 
#################################################################################




$Form.ShowDialog() | out-null




