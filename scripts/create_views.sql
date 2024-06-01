/*
    Creating Views: Percent Population Vaccinated
*/

DROP VIEW IF EXISTS Covid.PercentPopulationVaccinated;

CREATE VIEW Covid.PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM Covid.CovidDeaths dea
JOIN Covid.CovidVaccinations vac
  ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
