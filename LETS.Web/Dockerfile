#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["LETS.Web/LETS.Web.csproj", "LETS.Web/"]
COPY ["LETS.Web/NuGet.config", "LETS.Web/"]
COPY ["OrchardCore.LETS/LETS.csproj", "OrchardCore.LETS/"]
COPY NuGet.config .
RUN dotnet restore "LETS.Web/LETS.Web.csproj"
COPY . .
WORKDIR "/src/LETS.Web"
RUN dotnet build "LETS.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "LETS.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LETS.Web.dll"]