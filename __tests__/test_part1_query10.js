import { expect, describe, it } from '@jest/globals';
import './jest_extensions';

describe('Part 1 - Query 10', () => {
  it('should return the correct closest results', async () => {
    await expect('../part1/query10.sql')
      .toReturnRecords(
        ['expected_results/part1/query10asc.csv'],
        { orderBy: 'distance, station_id', limit: 5 },
      );
  });

  it('should return the correct farthest results', async () => {
    await expect('../part1/query10.sql')
      .toReturnRecords(
        ['expected_results/part1/query10desc.csv'],
        { orderBy: 'distance desc, station_id', limit: 5 },
      );
  });
});