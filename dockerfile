ARG BUILD_VERSION
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ARG BUILD_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && git clone --branch ${BUILD_VERSION} --depth 1 \
       https://github.com/marcselis/Easywave2MQTT.git /repo \
    && rm -rf /repo/.git
WORKDIR /repo/src
RUN dotnet publish Easywave2Mqtt/Easywave2Mqtt.csproj -c Release -o /app

FROM mcr.microsoft.com/dotnet/runtime:10.0
WORKDIR /app
COPY --from=build /app .
COPY --from=build /repo/src/Easywave2Mqtt/appsettings.json .
CMD ["dotnet", "Easywave2Mqtt.dll"]
