# Stage 1 - Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /src

COPY DevOpsLab.csproj ./

RUN dotnet restore DevOpsLab.csproj

COPY . .

RUN dotnet publish DevOpsLab.csproj \
    -c Release \
    -o /app/publish \
    --no-restore


# Stage 2 - Runtime
FROM mcr.microsoft.com/dotnet/runtime:9.0 AS final

WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "DevOpsLab.dll"]