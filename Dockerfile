FROM node:18-alpine
WORKDIR /app
RUN addgroup -S nonroot \
  && adduser -S nonroot -G nonroot \
  && printf '{ "name": "tmp", "version": "1.0.0", "dependencies": { "serve": "14.2.0" } }' > /app/package.json \
  && npm ci --ignore-scripts --unsafe-perm=false --no-audit --no-fund
COPY ./dist /app/dist
RUN chown -R nonroot:nonroot /app/dist && chmod -R go-w /app/dist
USER nonroot
EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
