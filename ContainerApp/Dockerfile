FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 64572
EXPOSE 44343

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["ContainerApp/ContainerApp.csproj", "ContainerApp/"]
RUN dotnet restore "ContainerApp/ContainerApp.csproj"
COPY . .
WORKDIR "/src/ContainerApp"
RUN dotnet build "ContainerApp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "ContainerApp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ContainerApp.dll"]