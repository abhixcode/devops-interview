CI/CD Pipeline
==============

The CI/CD pipeline is created using Github Actions as advised in the problem statement. It comprises of two jobs - build and deploy. I have used the standard .NET core template for this workflow which builds the .NET application and deploys it to the Azure App Service given in the workfow file.

Inafrastructure as Code (IaC)
=============================

IaC is achieved using Terraform with Azure. First, a resource group with a storage account and a container were created on Azure portal for use as Terraform backend.
Then, we implemented a worflow for terraform using Github which is triggered manually. In the terraform configuration, we create an Azure resource group, App service plan and App service for the given application.
