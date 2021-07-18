Start-UDDashboard -Wait -Dashboard (
    New-UDDashboard -Title "Hello, Azure" -Content {
        New-UDCard -Title "Hello, Azure"
    }
)