
# inspired by the official linux image: https://github.com/dotnet/dotnet-docker/blob/main/src/aspire-dashboard/8.0/cbl-mariner-distroless/amd64/Dockerfile

ARG PARENT_IMAGE=mcr.microsoft.com/dotnet/aspnet:8.0-windowsservercore-ltsc2022

# ---
FROM ${PARENT_IMAGE}

WORKDIR /app

ENV DOTNET_ASPIRE_VERSION=8.0.2

RUN curl -fSsL --output ./aspire_dashboard.zip https://dotnetbuilds.azureedge.net/public/aspire/%DOTNET_ASPIRE_VERSION%/aspire-dashboard-linux-x64.zip \
    && tar -xf ./aspire_dashboard.zip \
    && del .\\aspire_dashboard.zip

ENV ASPNETCORE_HTTP_PORTS= \
    ASPNETCORE_URLS=http://0.0.0.0:18888 \
    DOTNET_DASHBOARD_OTLP_ENDPOINT_URL=http://0.0.0.0:18889

ENTRYPOINT [ "dotnet", "/app/Aspire.Dashboard.dll" ]