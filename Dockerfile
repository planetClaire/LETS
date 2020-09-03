FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /source

# Copy csproj and restore
COPY LETS.Web/*.csproj ./LETS.Web/LETS.Web.csproj
COPY OrchardCore.LETS/*.csproj ./OrchardCore.LETS/LETS.csproj
COPY NuGet.config .
RUN dotnet restore LETS.Web/LETS.Web.csproj

# Copy everything else and build
COPY . ./
#RUN dotnet publish /source/LETS.Web -c Release -o ./build --no-restore
RUN dotnet publish -c Release -o build --no-restore

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /build
COPY --from=build-env /source/build ./
ENTRYPOINT ["dotnet", "LETS.Web.dll"]
