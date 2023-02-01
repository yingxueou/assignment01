import { expect, describe, it } from '@jest/globals';
import './jest_extensions';

describe('Part 1 - Query 11', () => {
  it('should return the correct closest results', async () => {
    await expect('../part1/query11.sql')
      .toReturnRecords(
        ['expected_results/part1/query11.csv'],
      );
  });
});